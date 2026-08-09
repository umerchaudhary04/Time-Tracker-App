# Time Tracking App

A Flutter application designed to help users efficiently track and manage the time spent on various tasks and projects. 

This project demonstrates effective state management, robust local data persistence, and a clean, scalable architecture. It ensures that all time entries, projects, and tasks are saved locally, meaning no data is lost when the app is closed and reopened.

## 🚀 Features

Based on the core user stories, this application includes the following functionality:
* **Time Entry Management:** Add time tracking entries with detailed fields for project, task, total time, date, and notes.
* **Task Organization:** View a comprehensive list of time spent on different tasks to manage activities efficiently.
* **Project Grouping:** Group time entries by projects to gain better insights into time distribution.
* **Data Persistence:** All entries, projects, and tasks are saved locally to preserve them across app sessions[cite: 1].
* **Entity Management:** Easily manage (add and delete) projects and tasks within the app settings[cite: 1].
* **Data Cleanup:** Delete unnecessary or incorrect time entries with a simple swipe-to-delete action[cite: 1].

## 🛠️ Tech Stack & Dependencies

This project is built with **Flutter** and relies on the following key packages[cite: 1]:
* `provider`: For scalable and maintainable state management[cite: 1].
* `localstorage`: For persisting user data locally on the device[cite: 1].
* `intl`: For date and time formatting[cite: 1].
* `collection`: For advanced list operations, such as grouping entries by project[cite: 1].

## 📁 Project Architecture

The application follows a clean separation of concerns, divided into the following directories[cite: 1]:
* **`lib/models/`**: Contains the data models (`project.dart`, `task.dart`, `time_entry.dart`)[cite: 1].
* **`lib/providers/`**: Contains the state management logic (`time_entry_provider.dart`) that acts as the single source of truth for the app's data[cite: 1].
* **`lib/screens/`**: Contains the main UI views (`home_screen.dart`, `add_time_entry_screen.dart`, `project_management_screen.dart`, `task_management_screen.dart`)[cite: 1].
* **`lib/widgets/`**: Contains reusable UI components, such as pop-up dialogs (`add_project_dialog.dart`, `add_task_dialog.dart`)[cite: 1].

## 💻 Getting Started

### Prerequisites
Make sure you have Flutter installed on your machine. If you are running this in a Cloud IDE, ensure your environment is properly configured.

### Installation
1. Clone or download the repository.
2. Navigate to the project directory in your terminal:
   ```bash
   cd time_tracker

## 📝 Future Enhancements
1. Implement data visualization (e.g., charts for time spent per project).

2. Add sorting and filtering for time entries.

3. Add a live timer featu (Start, Stop, Pause) for active task tracking.

## Author

Umer Chaudhary