AI For Good Hackathon - https://lu.ma/slx5t6ik?tk=s2GXhE
Video - https://drive.google.com/file/d/1UeC_JHnvTJAZagskJ4Mz-4Xv1yPeMJNA/view?usp=drive_link
# Solulu

Solulu is a social media app designed to reduce screen time for kids and teens by gamifying their passions and their friends' passions. It is the solution to the doom scrolling delusion. The app encourages users to engage in real-world activities through daily quests and shared challenges. 
The app supports UN Sustainable Development Goals 3 (Good Health and Well being), 4 (Quality Education), 11 (Sustainable cities and communities), 17 (Partnership for the goals).



## Features
- **User Authentication**: Login and signup screens for secure access.
- **Daily Quests**: AI-generated tasks based on user interests.
- **Friend-Based Challenges**: Activities created using shared hobbies among friends.
- **Task Validation**: Image-based verification to confirm task completion.
- **Gamification**: Rewards and achievements to keep users engaged.
  
<img width="953" alt="Screenshot 2025-03-09 at 4 50 41 PM" src="https://github.com/user-attachments/assets/c697e8cd-1d7e-4464-9610-e587e1447b12" />

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

  <img width="548" alt="Screenshot 2025-03-09 at 4 51 02 PM" src="https://github.com/user-attachments/assets/9690bd4b-1206-4cee-834c-a619dbbe4b78" />


## Installation & Setup
### Prerequisites
- Xcode (for iOS app development)
- Python 3.8+
- Neo4j and Qdrant database instance
- Groq API access



### Steps


1. **Clone the Repository**:
   ```sh
   git clone https://github.com/yourusername/solulu.git
   cd solulu
   ```
2. **Create groq api key and update it in server.py**
   
3. **Setup Neo4j**:
   - Install Neo4j, qdrant and start the database.

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




