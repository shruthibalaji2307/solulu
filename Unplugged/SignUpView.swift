import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var gender: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showSuccessMessage = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.7)]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Sign Up")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                
                Group {
                    TextField("Name", text: $name)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    TextField("Gender", text: $gender)
                    TextField("Username", text: $username).autocapitalization(.none)
                    SecureField("Password", text: $password).autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(0.6))
                .cornerRadius(10)
                .padding(.horizontal, 30)
                .foregroundColor(.black)
                
                Button(action: {
                    // Handle sign-up logic here
                    showSuccessMessage = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 250)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                }
                
                if showSuccessMessage {
                    Text("You have successfully signed up! Let's #StepOutWithSolulu!")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.2))
                                .padding(.horizontal, -10)
                        )
                }
            }
            .padding()
        }
    }
} 