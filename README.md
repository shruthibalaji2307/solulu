# solulu
# Solulu

Solulu is a social media app designed to reduce screen time for kids and teens by gamifying their passions and their friends' passions. The app encourages users to engage in real-world activities through daily quests and shared challenges.

## Features
- **User Authentication**: Login and signup screens for secure access.
- **Daily Quests**: AI-generated tasks based on user interests.
- **Friend-Based Challenges**: Activities created using shared hobbies among friends.
- **Task Validation**: Image-based verification to confirm task completion.
- **Gamification**: Rewards and achievements to keep users engaged.

## Tech Stack
### Frontend
- **Xcode & Swift**: iOS development for an intuitive and engaging user interface.

### Backend
- **Python Server**: Handles API requests and communication between components.
- **Groq**:
  - Generates daily quests tailored to user interests.
  - Validates task completion by analyzing uploaded images.
- **Neo4j**:
  - Manages user relationships and hobbies.
  - Generates friend-based tasks using graph-based analysis.

## Installation & Setup
### Prerequisites
- Xcode (for iOS app development)
- Python 3.8+
- Neo4j database instance
- Groq API access

### Steps


1. **Clone the Repository**:
   ```sh
   git clone https://github.com/yourusername/solulu.git
   cd solulu
   ```
2. **Create groq api key and update it in server.py**
   
3. **Setup Neo4j**:
   - Install Neo4j and start the database.

4. **Run the Backend Server**:
   ```sh
   python3 server.py
   ```

5. **Open Xcode and Run the iOS App**:
   - Open `ios/Solulu.xcodeproj` in Xcode.
   - Select a simulator or connected device.
   - Click "Run".

## Contributing
Contributions are welcome! Please open an issue or submit a pull request.

## License
This project is licensed under the MIT License.



