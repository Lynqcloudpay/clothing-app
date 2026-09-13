# ThreadSense 🧵✨

An AI-powered styling app that leverages the device camera to perform highly accurate 3D body scans, extracts precise measurements, and recommends currently trending clothing tailored to the user's exact body type.

## Core Features
1. **3D Body Scanning**: Uses ARKit/ARCore and Google ML Kit for robust pose estimation and depth mapping to construct a millimeter-accurate 3D avatar.
2. **AI Recommendation Engine**: Vertex AI / Gemini integration matches trending garments scraped from top fashion retailers directly to the user's specific body type and fit preferences.
3. **Immersive Social Feed**: A TikTok-style vertical scrolling feed featuring interactive outfit cards and personalized size recommendations.
4. **Premium Design**: Dark-mode-first aesthetic with smooth glassmorphism, animated gradients, and 60fps micro-interactions using Flutter Animate.

## Architecture
- **Framework**: Flutter (Dart)
- **State Management**: Riverpod
- **Backend**: Firebase (Auth, Firestore, Cloud Functions)
- **ML & AR**: `google_mlkit_pose_detection`, `arkit_plugin`, `arcore_flutter_plugin`

## Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Firebase CLI
- Xcode (for iOS ARKit testing)
- Android Studio (for Android ARCore testing)

### Setup
1. Clone the repository
2. Run `flutter pub get`
3. Setup Firebase:
   ```bash
   firebase login
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
4. Generate Freezed models:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
5. Run the app on a physical device (Simulators do not support AR camera features):
   ```bash
   flutter run
   ```

## Folder Structure
```
lib/
 ┣ config/       # Theme, constants, routing
 ┣ core/         # Shared widgets, models, providers, services
 ┗ features/     # Feature-first modules (auth, feed, product, profile, scanning)
```

## Contributing
1. Create a feature branch
2. Ensure `flutter analyze` passes
3. Write unit tests for new business logic
4. Submit a PR
