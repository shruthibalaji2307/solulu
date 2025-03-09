import SwiftUI

// First Screen: Interest Selection
struct InterestSelectionView: View {
    @State private var selectedInterests: [String] = []
    @State private var navigateToChallenges = false
    
    let interests = ["Reading", "Surfing", "Photography", "Volunteering", "Chess", "Swimming"]
    
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

import SwiftUI

// Home Screen: Displays the Daily Challenge + Leaderboard
struct HomeScreen: View {
    var selectedInterests: [String]
    
    @State private var dailyChallenge = "Catch 3 Waves: Spend 30 minutes surfing today and ride at least 3 waves to earn your Beach badge 🌊!"
    @State private var auraPoints = 0
    @State private var streak = 0
    @State private var showConfetti = false
    @State private var navigateToSocialChallenge = false
    
    // Dummy Leaderboard Data
    let leaderboard = [
        ("Meghan", 1200, 15),
        ("Hana", 870, 10),
        ("You", 800, 8),
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) { // Reduced spacing
//                Text("OffScreen")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .padding(.top, 40)
                
                Text("Daily Challenge")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white.opacity(0.9))
                
                // Daily Challenge Box
                Text(dailyChallenge)
                    .padding(20)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .frame(maxWidth: 320, minHeight: 120)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.2))
                            .shadow(radius: 5)
                    )
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                
                // Complete Challenge Button
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
                
                // I'm Feeling Social Button
                NavigationLink(destination: SocialChallengeScreen(), isActive: $navigateToSocialChallenge) {
                    EmptyView()
                }
                .hidden()

                // Reduced spacing between buttons
                Button(action: {
                    navigateToSocialChallenge = true
                }) {
                    HStack {
                        Image(systemName: "person.3.fill")
                            .font(.title)
                        Text("Vibe with the Tribe")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 250)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.pink]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
                .padding(.top, 2) // Reduced spacing between buttons
                
                Text("Aura Points: \(auraPoints) | Streak: \(streak)🔥")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.top, 5) // Reduced spacing
                
                // Leaderboard Section
                Text("Leaderboard")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 5) // Reduced spacing
                
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


// Invites Screen
struct InvitesScreen: View {
    // Dummy Data for Invites
    @State private var invites = [
        ("Jayden", "Join me for a beach cleaning activity with Surfrider Foundation 🧹", "March 15, 10:00 AM"),
        ("Leah", "Join me for a college essay review session! 🎓", "March 16, 5:30 PM"),
        ("Meghan", "Join me for a beginner surfing class! 🏄", "March 17, 9:00 AM")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.blue.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Your Invites")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(invites.indices, id: \.self) { index in
                            InviteCard(invite: invites[index]) {
                                invites.remove(at: index)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
            }
        }
    }
}

// Invite Card Component
struct InviteCard: View {
    var invite: (String, String, String)
    var onAccept: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(invite.0) invited you!")
                .font(.headline)
                .foregroundColor(.white)
            
            Text(invite.1)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
            
            Text("📅 \(invite.2)")
                .font(.footnote)
                .foregroundColor(.yellow)
            
            HStack {
                Button(action: onAccept) {
                    Text("✅ Accept")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }
                
                Button(action: onAccept) {
                    Text("❌ Reject")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.2)))
        .shadow(radius: 5)
    }
}


// Social Challenge Screen
struct SocialChallengeScreen: View {
    @State private var socialChallenge = "Looks like Hana Nguyen is a fellow reader and she runs a book club 📖👓 Suggest Remarkaby Bright Creatures as the upcoming book for Hana's book club discussions and invite her and Meghan for a book club discussion!"
    
    // Dummy friends for graphical representation
    let friends = ["Hana", "Meghan"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.8), Color.orange.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Social Challenge")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                // Social Challenge Box
                Text(socialChallenge)
                    .padding(20)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .frame(maxWidth: 320, minHeight: 120)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.2))
                            .shadow(radius: 5)
                    )
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                
                // Graphical Representation of Friends
                Text("You're doing this challenge with:")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.top, 10)
                
                HStack {
                    ForEach(friends, id: \.self) { friend in
                        VStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.yellow)
                            
                            Text(friend)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                }
                
                
                Button(action: {print(".")})
                {
                    Text("Send invite 📅")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }
                
                Spacer()
            }
        }
    }
}



// Activity Screen with Images and "Send Good Vibes" Button
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
                    ActivityPost(
                        text: "Gabriel just finished his physical chess match with his dad and beat him! ♟️🎉",
                        imageName: "chess"
                    )
                    
                    ActivityPost(
                        text: "Meghan just finished her morning swim in the pool! 🏊",
                        imageName: "swimming"
                    )
                    
                    ActivityPost(
                        text: "Leah just met with a couple of college students to interview them about their college application process 🎓",
                        imageName: "interview"
                    )
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

// Custom View for Activity Post (Text + Image + "Send Good Vibes" Button)
struct ActivityPost: View {
    var text: String
    var imageName: String
    
    @State private var vibeCount = 0
    @State private var hasSentVibe = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(text)
                .foregroundColor(.black)
                .font(.headline)
                .padding(.bottom, 5)
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            // "Send Good Vibes" Button
            HStack {
                Button(action: {
                    if !hasSentVibe {
                        vibeCount += 1
                        hasSentVibe = true
                    }
                }) {
                    HStack {
                        Image(systemName: hasSentVibe ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .foregroundColor(hasSentVibe ? .green : .white)
                        Text(hasSentVibe ? "Vibes Sent! ✨" : "Send Good Vibes 💫")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.pink]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                
                Spacer()
                
                Text("Vibes: \(vibeCount)")
                    .foregroundColor(.yellow)
                    .fontWeight(.bold)
            }
        }
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.2)))
        .shadow(radius: 5)
    }
}

// Main ContentView with Tabs
struct ContentView: View {
    var selectedInterests: [String]
    
    var body: some View {
        TabView {
            // Home screen
            NavigationStack {
                HomeScreen(selectedInterests: selectedInterests)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            // Activity / Feed screen
            NavigationStack {
                ActivityScreen()
            }
            .tabItem {
                Label("Activity", systemImage: "chart.bar.fill")
            }
            // Invites Tab
            NavigationStack {
                InvitesScreen()
            }
            .tabItem {
                Label("Invites", systemImage: "envelope.fill")
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
