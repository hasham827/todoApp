# Todo App in Flutter

## Overview
This project is a Todo app developed using Flutter. The application offers a seamless user experience for managing tasks with the following key functionalities:
1. **User Authentication**: Users can sign up, log in, and manage their sessions securely.
2. **Task Management**: Users can view, add, edit, and delete their tasks.
3. **Pagination**: Efficiently fetch and display a large number of tasks using pagination.
4. **State Management**: State management implemented using the Provider package.
5. **Local Storage**: Tasks are persisted locally using Flutter's SQLite database.

## Features
### User Authentication
- Secure user authentication implemented to allow users to sign up and log in.
- Session management to maintain user state across app restarts.

### Task Management
- Users can add new tasks with details.
- Tasks can be edited or deleted.
- Tasks are displayed in a list format for easy viewing.

### Pagination
- Implemented pagination to load tasks efficiently, reducing the load on the app and improving performance.

### State Management
- Used the Provider package for managing state across the application, ensuring a reactive and efficient UI.

### Local Storage
- Utilized SQLite for local task storage, allowing offline access to tasks.
- Synced local storage with server data to ensure tasks are up-to-date when the user is online.

## Challenges Faced
### Managing Todo Tasks with Local Storage and Server Data
One of the primary challenges was managing tasks efficiently when the user was both online and offline. This involved several complexities:

- **Data Synchronization**: Ensuring that the local SQLite database and the server data were always in sync, particularly when the user transitions between offline and online states.
- **Conflict Resolution**: Handling conflicts that arose when changes were made to the same task on both local storage and the server while the user was offline.
- **Efficient Data Handling**: Implementing pagination not only for server data but also ensuring that the local database operations were efficient and did not slow down the app.
- **State Management**: Keeping the app state consistent and updated in real-time across different parts of the app using the Provider package.

To tackle these challenges, several strategies were employed:
- **Background Syncing**: Implemented background processes to sync data periodically and whenever the network state changed.
- **Conflict Management Algorithms**: Developed algorithms to resolve conflicts between local and server data based on timestamps and user actions.
- **Optimized Database Queries**: Ensured that SQLite queries were optimized for speed and efficiency, particularly when dealing with large datasets.
- **Reactive State Updates**: Leveraged the Provider package to ensure that any changes in the data were immediately reflected in the UI, providing a smooth user experience.

## Getting Started
To run the project locally, follow these steps:

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/hasham827/todoApp.git
    cd todoApp
    ```

2. **Install Dependencies**:
    ```bash
    flutter pub get
    ```

3. **Run the App**:
    ```bash
    flutter run
    ```

## Conclusion
This Todo app demonstrates the power and flexibility of Flutter in creating feature-rich applications. By addressing the challenges of data management and synchronization, the app ensures a robust user experience both online and offline. Contributions and feedback are welcome to further improve the application.
