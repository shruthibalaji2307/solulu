import SwiftUI

// First Screen: Interest Selection
struct InterestSelectionView: View {
    @State private var selectedInterests: [String] = []
    @State private var navigateToChallenges = false
    
    let interests = ["Reading", "Trading", "Photography", "Dance", "Music", "Instruments", "Puzzles", "Sports", "Cooking", "Writing"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Select Your Interests")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("This helps us customize your daily challenges! 🎯")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(interests, id: \.self) { interest in
                                InterestCheckbox(interest: interest, isSelected: selectedInterests.contains(interest)) {
                                    toggleSelection(for: interest)
                                }
                            }
                        }
                        .padding()
                    }
                    .frame(height: 300)
                    
                    NavigationLink(destination: ContentView(selectedInterests: selectedInterests)) {
                        Text("Start My Challenges ✅")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 250)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                }
                .padding()
            }
        }
    }
    
    func toggleSelection(for interest: String) {
        if selectedInterests.contains(interest) {
            selectedInterests.removeAll { $0 == interest }
        } else {
            selectedInterests.append(interest)
        }
    }
}

// Checkbox Component for Interest Selection
struct InterestCheckbox: View {
    let interest: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(interest)
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                Spacer()
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(isSelected ? .green : .white)
                    .font(.title2)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.2)))
            .shadow(radius: 3)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Home Screen: Displays the Daily Challenge + Leaderboard
struct HomeScreen: View {
    var selectedInterests: [String]
    
    @State private var dailyChallenge = "Go for a 15-minute walk and take a photo of something cool!"
    @State private var auraPoints = 0
    @State private var streak = 0
    @State private var showConfetti = false
    
    // Dummy Leaderboard Data
    let leaderboard = [
        ("Alice", 1200, 15),
        ("Bob", 950, 12),
        ("Charlie", 870, 10),
        ("You", 800, 8),
        ("David", 750, 7)
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("OffScreen")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                Text("Daily Challenge")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white.opacity(0.9))
                
                Text(dailyChallenge)
                    .padding()
                    .multilineTextAlignment(.center)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.2))
                            .shadow(radius: 5)
                    )
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                
                Button(action: completeChallenge) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title)
                        Text("Complete Challenge")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 250)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .scaleEffect(showConfetti ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: showConfetti)
                }
                
                Text("Aura Points: \(auraPoints) | Streak: \(streak)🔥")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .padding()
                
                // Leaderboard Section
                Text("Leaderboard")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                VStack {
                    ForEach(leaderboard, id: \.0) { user in
                        HStack {
                            Text("\(user.0)")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            Spacer()
                            Text("🔥 \(user.2) Streak")
                                .foregroundColor(.orange)
                            Text("✨ \(user.1) Aura Points")
                                .foregroundColor(.yellow)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.2)))
                        .shadow(radius: 3)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.bottom, 40)
        }
    }
    
    func completeChallenge() {
        auraPoints += 10
        streak += 1
        showConfetti = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showConfetti = false
        }
        dailyChallenge = "New challenge coming soon! 🎯"
    }
}


// Activity Screen: Similar Theme as Home
struct ActivityScreen: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Activity Feed")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                Text("See what others are up to!")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.9))
                
                List {
                    Text("Sarah completed her daily challenge! 🎉")
                    Text("Jake just went for a morning hike! 🌄")
                    Text("Lily is learning guitar today! 🎸")
                }
                .scrollContentBackground(.hidden) // Keep background style
                .background(Color.clear)
                .cornerRadius(10)
                .padding()
                
                Spacer()
            }
        }
    }
}

// Main ContentView with Tabs
struct ContentView: View {
    var selectedInterests: [String]
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeScreen(selectedInterests: selectedInterests)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            NavigationStack {
                ActivityScreen()
            }
            .tabItem {
                Label("Activity", systemImage: "chart.bar.fill")
            }
        }
    }
}

// Main App Entry
//@main
struct OffScreenApp: App {
    var body: some Scene {
        WindowGroup {
            InterestSelectionView()
        }
    }
}
