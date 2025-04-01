# To-Do List App

<p align="center">
  <img src="screenshots/app_logo.png" alt="TaskMaster Pro Logo" width="200"/>
</p>

<p align="center">
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-v3.10.0-blue?logo=flutter" alt="Flutter Version"></a>
  <a href="https://dart.dev"><img src="https://img.shields.io/badge/Dart-v3.0.0-blue?logo=dart" alt="Dart Version"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-purple.svg" alt="License"></a>
</p>

## 📱 Overview

TaskMaster Pro is a beautiful, feature-rich todo application built with Flutter. Designed with simplicity and visual appeal in mind, it helps users manage their daily tasks efficiently.

## ✨ Features

- **Intuitive UI**: Clean, modern interface with smooth animations
- **Task Management**: Create, edit, and delete tasks with ease
- **Progress Tracking**: Visual indicators show your completion status
- **Custom Navigation**: Elegant slide-out drawer for easy navigation
- **Data Persistence**: Tasks are stored locally using Hive database
- **Animations**: Smooth transitions and animations throughout the app

## 📸 Screenshots

<p align="center">
  <img src="screenshots/home_screen.png" width="250" alt="Home Screen"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="screenshots/drawer_menu.png" width="250" alt="Drawer Menu"/>
</p>

<p align="center">
  <img src="screenshots/add_task.png" width="250" alt="Add Task"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="screenshots/task_completed.png" width="250" alt="Tasks Completed"/>
</p>

## 🛠️ Technologies Used

- **Flutter**: UI framework
- **Dart**: Programming language
- **Hive**: Local database for storing tasks
- **animate_do**: For beautiful animations
- **Lottie**: For engaging animation assets
- **flutter_slider_drawer**: For the slide-out menu functionality

## 📥 Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/taskmaster-pro.git
```

2. Navigate to the project directory:
```bash
cd taskmaster-pro
```

3. Get packages:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## 🏗️ Project Structure

```
lib/
├── main.dart             # Entry point
├── models/               # Data models
│   └── task.dart         # Task model
├── utils/                # Utility classes
│   ├── colors.dart       # Color constants
│   ├── constants.dart    # App constants
│   └── strings.dart      # String constants
├── view/                 # UI components
│   ├── home/             # Home screen
│   │   ├── home_view.dart
│   │   └── widgets/      # Home screen widgets
│   └── tasks/            # Task screens
│       └── task_view.dart
```

## 🔜 Future Enhancements

- Task categories and tags
- Dark mode support
- Cloud synchronization
- Due date and reminders
- Task priorities
- Statistics and reports

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/yourusername/taskmaster-pro/issues).

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


