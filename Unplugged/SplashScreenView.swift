import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if isActive {
                    LoginView()
                } else {
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
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
                }
            }
        }
    }
} 