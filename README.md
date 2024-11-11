# ChatHub

ChatHub is a real-time messaging application that allows users to chat with each other. The application utilizes WebSocket for real-time communication, MongoDB for data storage, and Flutter for the mobile front-end.

## Features
- Real-time messaging using WebSocket.
- User authentication and registration.
- Messages are stored in MongoDB.
- Flutter-based mobile app for users to interact.

## Technologies Used
- **WebSocket** for real-time communication.
- **MongoDB** for message and user data storage.
- **Flutter** for the mobile application.
- **Dart** for programming in Flutter.

## Setup Instructions

### Backend Setup (WebSocket & MongoDB)
1. Navigate to the backend directory:
   ```bash
    cd ChatHub/Back-End/server
    ```
    Run the following command to install necessary packages:
     ```bash 
     npm install
     ```
2. Set up MongoDB:
    Use either a local MongoDB instance or MongoDB Atlas for cloud hosting.
    Create a .env file in the backend directory and add the following environment variables:
    ```bash
    MONGODB_URI=mongodb://your-mongo-uri
    PORT=3000
    ```

3. Start the WebSocket server:
    ```bash
    node server.js
    ```
### Frontend Setup (Flutter)
1. Navigate to the frontend directory:
    ```bash
    cd ChatHub/Front-End
    ```
2. Install Flutter dependencies:
    Make sure you have Flutter SDK installed.
    Run the following command to get the required packages:
    ```bash
    flutter pub get
    ```
3. Configure WebSocket connection:

    In your Flutter app, update the WebSocket URL to point to your backend server.

4. Run the Flutter application:
    ```bash
    flutter run
    ```
### Contributing  
  This project is licensed under the GPL-3.0 License - see the LICENSE file for details.
