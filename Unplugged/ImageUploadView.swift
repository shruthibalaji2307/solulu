import SwiftUI

struct ImageUploadView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var showSuccessMessage = false
    @State private var isUploading = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            } else {
                Text("Upload an image to complete the challenge")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            
            Button(action: {
                showImagePicker = true
            }) {
                Text("Select Image")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 250)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
            
            if selectedImage != nil {
                Button(action: uploadImage) {
                    Text("Upload")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                .padding(.top, 10)
            }
            
            if isUploading {
                ProgressView("Uploading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
            
            if showSuccessMessage {
                Text("Challenge completed successfully! Aura Points: 100")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding()
    }
    
    func uploadImage() {
        isUploading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isUploading = false
            showSuccessMessage = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
} 