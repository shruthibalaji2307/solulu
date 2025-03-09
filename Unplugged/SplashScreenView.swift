import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if isActive {
                    WelcomeView()
                } else {
                    VStack {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                        
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