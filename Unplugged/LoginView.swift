import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.7)]), 
                             startPoint: .top, 
                             endPoint: .bottom)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        Spacer()
                            .frame(height: 50)
                        
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                        
                        Text("Login")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        VStack(spacing: 20) {
                            TextField("Username", text: $username)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 30)
                                .autocapitalization(.none)
                                .frame(maxWidth: 350)
                                .onSubmit {
                                    attemptLogin()
                                }
                            
                            SecureField("Password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 30)
                                .autocapitalization(.none)
                                .frame(maxWidth: 350)
                                .onSubmit {
                                    attemptLogin()
                                }
                        }
                        
                        Button(action: attemptLogin) {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: 250)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), 
                                                         startPoint: .leading, 
                                                         endPoint: .trailing))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }
                        .padding(.top, 10)
                        
                        Button(action: {
                            // Placeholder for forgot password action
                        }) {
                            Text("Forgot password?")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(.top, 5)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        NavigationLink(destination: InterestSelectionView(), 
                                     isActive: $isLoggedIn) {
                            EmptyView()
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func attemptLogin() {
        // Dummy login action
        if !username.isEmpty && !password.isEmpty {
            isLoggedIn = true
        }
    }
}