import SwiftUI

struct ImageUploadView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var showSuccessMessage = false
    @State private var isUploading = false
    @State private var verificationMessage: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var taskDescription: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Complete Challenge: \(taskDescription)")
                .font(.headline)
                .padding()
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            } else {
                Text("Select an image to complete the challenge")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            
            Button(action: {
                showImagePicker = true
            }) {
                Text("Choose Image")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .padding(.top, 10)
            
            if selectedImage != nil {
                Button(action: uploadImage) {
                    Text("Upload")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 250)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
            }
            
            if isUploading {
                ProgressView("Verifying...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
            
            if !verificationMessage.isEmpty {
                Text(verificationMessage)
                    .font(.headline)
                    .foregroundColor(showSuccessMessage ? .green : .red)
                    .padding()
            }
        }
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(selectedImage: $selectedImage)
        }
    }
    
    func uploadImage() {
        isUploading = true
        
        // Convert UIImage to PNG data
        guard let selectedImage = selectedImage,
            // let resizedImage = resizeImage(selectedImage, targetSizeKB: 1000),
            let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to PNG data")
            verificationMessage = "Error preparing image"
            isUploading = false
            return
        }
        
        print("Image data size: \(imageData.count) bytes")
        
        let url = URL(string: "http://localhost:5000/verify")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.setValue(taskDescription, forHTTPHeaderField: "Task")
        
        request.httpBody = imageData
        
        print("Task description: \(taskDescription)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Network error: \(error.localizedDescription)")
                    isUploading = false
                    verificationMessage = "Error: \(error.localizedDescription)"
                    return
                }
                
                if let data = data {
                    print("Received response data length: \(data.count)")
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let result = json["result"] as? Bool {
                        print("Verification result: \(result)")
                        isUploading = false
                        showSuccessMessage = result
                        verificationMessage = result ? "Challenge completed successfully! Aura Points: 100" : "This image doesn't match the challenge. Try again!"
                        if result {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                }
            }
        }.resume()
    }
}

// Image Picker View
struct ImagePickerView: View {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    let mockImages = ["mockImage"] // Add more mock image names from assets here
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(mockImages, id: \.self) { imageName in
                        if let image = UIImage(named: imageName) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .onTapGesture {
                                    selectedImage = image
                                    presentationMode.wrappedValue.dismiss()
                                }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Select Image")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

func resizeImage(_ image: UIImage, targetSizeKB: Int) -> UIImage? {
    let targetSizeBytes = targetSizeKB * 1024
    var compression: CGFloat = 1.0
    var imageSize = image.size
    
    // First try just compressing the existing image
    if let data = image.jpegData(compressionQuality: 0.8), data.count <= targetSizeBytes {
        return image
    }
    
    // If still too large, resize the dimensions
    while true {
        let ratio = sqrt(CGFloat(targetSizeBytes) / CGFloat(image.jpegData(compressionQuality: 0.8)?.count ?? 0))
        imageSize = CGSize(width: imageSize.width * ratio, height: imageSize.height * ratio)
        
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        let resized = renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: imageSize))
        }
        
        if let data = resized.jpegData(compressionQuality: 0.8), data.count <= targetSizeBytes {
            return resized
        }
        
        if imageSize.width < 200 || imageSize.height < 200 {
            // Prevent image from becoming too small
            return resized
        }
    }
}