# ConnectMe — Community App

ConnectMe is a Flutter community application that allows users to authenticate, share posts, explore community members on a map, and manage their profiles with device-aware features.

The project is built with Flutter and Firebase, using a layered architecture and Cubit-based state management.

## Features

### Authentication

* User registration and login using Firebase Authentication.
* Form validation for user inputs.
* Authentication state management using Cubit.
* Persistent authentication state through Firebase Authentication.
* Logout functionality.

### Community Feed

* Retrieve and display community posts from Cloud Firestore.
* Create posts through the home screen.
* Display post information using reusable post cards.
* Manage post-related states using Cubit.
* Separate post data access and repository logic.

### User Profile

* Display the user's name and email.
* Display device model and operating system version.
* Change the profile picture using the device gallery or camera picker.
* Store the selected profile image locally on the device.
* Protect access to the profile screen using biometric authentication.

> **Profile image note:** Profile pictures are stored locally on the device in the current implementation. They are not uploaded to Firebase Storage, so the selected image may not appear on another device.

### Community Map

* Display a Google Map in the Community Map screen.
* Show member markers in different cities.
* Display a member's name and city through the marker information window.
* Navigate to the map from the bottom navigation bar.

The current map uses sample member locations defined in the application code.

## Tech Stack

| Technology              | Purpose                                 |
| ----------------------- | --------------------------------------- |
| Flutter & Dart          | Cross-platform application development  |
| Firebase Core           | Firebase initialization                 |
| Firebase Authentication | User authentication                     |
| Cloud Firestore         | Community posts and remote data         |
| Flutter Bloc / Cubit    | State management                        |
| GetIt                   | Dependency injection                    |
| Google Maps Flutter     | Interactive community map               |
| Image Picker            | Selecting profile images                |
| Local Auth              | Biometric authentication                |
| Device Info Plus        | Reading device information              |
| Path Provider           | Accessing local application directories |
| Dartz                   | Functional programming utilities        |

## Architecture

The project separates presentation, domain, and data responsibilities.

```text
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── helper/
│   └── style/
│
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
├── presentation/
│   ├── blocs/
│   ├── screens/
│   └── widgets/
│
├── services/
├── firebase_options.dart
└── main.dart
```

### Layer Responsibilities

* **Core:** Shared constants, styles, validation helpers, dependency injection, and failure definitions.
* **Data:** Data sources, data models, and repository implementations for accessing remote or local data.
* **Domain:** Core entities, repository contracts, and use cases.
* **Presentation:** Screens, reusable widgets, and Cubits that manage UI state.
* **Services:** Shared Firebase-related services and supporting functionality.

## Design Patterns and Principles

The project structure supports separation of concerns and maintainability.

* **Repository Pattern:** Repository contracts and implementations separate application logic from data access.
* **Factory Pattern:** The post data source factory is used to select the appropriate post data source.
* **Dependency Injection:** GetIt provides registered dependencies to the application components.
* **Singleton:** Shared services can be registered as single instances through dependency injection.
* **Builder Pattern:** The user model can use a Builder to construct profile objects when implemented by the model.

The exact behavior of each pattern depends on its implementation in the corresponding source file.

## Getting Started

### Prerequisites

Install the following tools:

* Flutter SDK compatible with the project's Dart SDK constraint.
* Dart SDK included with Flutter.
* Android Studio or another supported Flutter development environment.
* A configured Android emulator or physical Android device.
* A Firebase project.
* A Google Maps API key for Android map functionality.

### 1. Clone the Repository

```bash
git clone https://github.com/fatima304/Connect_Me.git
cd Connect_Me
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

1. Create or select a project in the [Firebase Console](https://console.firebase.google.com/).

2. Register the Android application using its actual application ID.

3. Download the generated `google-services.json` file.

4. Place it in:

   `android/app/google-services.json`

5. Enable **Email/Password** authentication in Firebase Authentication.

6. Create a Cloud Firestore database and configure its security rules.

7. Configure the FlutterFire options for the Firebase project.

The project includes `lib/firebase_options.dart`. If you are using a different Firebase project, regenerate the configuration using the FlutterFire CLI and verify that the Android and Dart configurations refer to the same project.

**Security:** Never commit service-account credentials or unrestricted secrets. Firestore security rules should prevent unauthorized access to user data and posts.

### 4. Configure Google Maps

1. Open the [Google Cloud Console](https://console.cloud.google.com/).
2. Select the Google Cloud project associated with your Maps configuration.
3. Enable **Maps SDK for Android**.
4. Create an API key and restrict it to the Android application and the appropriate signing certificate SHA-1.
5. Add the key to `android/app/src/main/AndroidManifest.xml` inside the `<application>` element:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_RESTRICTED_GOOGLE_MAPS_API_KEY" />
```

Replace the placeholder with your own restricted key. Do not copy a personal API key from another developer's configuration.

Depending on your Google Cloud account and usage, billing may be required for Maps services.

### 5. Run the Application

```bash
flutter run
```

## Project Screens

The following screenshots can be added to the repository to document the main application flows:

| Screen                    | Screenshot                         |
| ------------------------- | ---------------------------------- |
| Login                     | `screenshots/login.png`            |
| Sign Up                   | `screenshots/signup.png`           |
| Home Feed                 | `screenshots/home.png`             |
| Biometric Authentication  | `screenshots/biometric.png`        |
| User Profile              | `screenshots/profile.png`          |
| Community Map             | `screenshots/community_map.png`    |
| Firebase App Distribution | `screenshots/app_distribution.png` |

Create the `screenshots/` directory and add the corresponding screenshots before publishing this documentation. Until those images exist in the repository, these paths are placeholders.

## Testing and Code Quality

Run static analysis:

```bash
flutter analyze
```

Run the available automated tests:

```bash
flutter test
```

Format the Dart code:

```bash
dart format lib test
```

Manual testing should cover registration, login, logout, post creation and loading, profile image selection, biometric authentication, device information, and map marker interactions.

## Android Release Build

Generate a release APK with:

```bash
flutter build apk --release
```

The generated APK is normally located at:

`build/app/outputs/flutter-apk/app-release.apk`

Verify that the release build installs and runs correctly before distributing it.

## Firebase App Distribution

To distribute a beta build:

1. Open the Firebase Console and select the project.
2. Open App Distribution.
3. Upload the release APK.
4. Add at least two tester email addresses.
5. Send the invitations.
6. Confirm that the testers receive their invitations and can install the application.
7. Capture screenshots of the distribution dashboard and tester invitations for the project documentation.

Complete these steps before marking beta distribution as finished.

## Current Limitations

* Community map markers currently use sample, hardcoded member locations.
* Profile pictures are stored locally rather than uploaded to Firebase Storage.
* Map functionality requires a valid, appropriately restricted Google Maps API key.
* Beta distribution and tester installation should be verified against the actual Firebase project before submission.

## Repository

GitHub: [ConnectMe — Community App](https://github.com/fatima304/Connect_Me)

## License

Add a license if you intend to distribute or reuse this project under specific open-source terms.
