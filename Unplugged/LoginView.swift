import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.red, lineWidth: 4)
                        .frame(width: 100, height: 150)
                    
                    Text("X")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.green)
                }
                
                Text("Solulu")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            .padding(.top, 40)
            
            Spacer()
            
            VStack(spacing: 20) {
                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)
                    .onSubmit {
                        attemptLogin()
                    }
                
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)
                    .onSubmit {
                        attemptLogin()
                    }
                
                Button(action: attemptLogin) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 250)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                }
                
                Button(action: {
                    // Placeholder for forgot password action
                }) {
                    Text("Forgot password?")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
            
            NavigationLink(destination: InterestSelectionView(), isActive: $isLoggedIn) {
                EmptyView()
            }
        }
        .padding()
        .background(Color.black.opacity(0.8).ignoresSafeArea()) // Darker background
    }
    
    private func attemptLogin() {
        // Dummy login action
        if !username.isEmpty && !password.isEmpty {
            isLoggedIn = true
        }
    }
} 