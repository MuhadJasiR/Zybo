# Flutter Project Setup

## 📌 Prerequisites
Before setting up the Flutter project, ensure you have the following installed:

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (comes with Flutter)
- **Android Studio** (for Android development)
- **Xcode** (for iOS development - macOS only)
- **VS Code or IntelliJ** (optional, but recommended for development)

## 🚀 Getting Started

### 1️⃣ Clone the Repository
```sh
  git clone <git@github.com:MuhadJasiR/Zybo.git>
```

### 2️⃣ Install Dependencies
```sh
  flutter pub get
```

### 3️⃣ Run the Project
#### Android
```sh
  flutter run
```

#### iOS
```sh
  cd ios && pod install && cd ..
  flutter run
```

#### Web
```sh
  flutter run -d chrome
```

### 4️⃣ Build APK/IPA
#### Android (APK)
```sh
  flutter build apk --release
```

#### iOS (IPA)
```sh
  flutter build ios --release
```

## 📂 Folder Structure
```sh
lib/
 ├── core/          # Theme, Constants, Utilities
 ├── data/          # API Calls, Repositories
 ├── domain/        # Business Logic, Use Cases
 ├── presentation/  # UI Screens, Widgets, Bloc
```

## ✅ Additional Notes
- Run `flutter doctor` to check for any missing dependencies.
- Use `flutter clean` if you face build issues.
- Follow the **Bloc Pattern** for state management (if applicable).

