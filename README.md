# Kobi Frontend Engineer Assessment – Transaction App

This Flutter application is a transaction management tool that simulates Netflix expense tracking. It demonstrates state management, UI design, and refund functionality, created as part of the Kobi Frontend Engineer Assessment.

## 🚀 Setup Instructions

1. **Install Flutter**
    - Ensure Flutter SDK version 3.24.4 or later is installed. Follow the [official installation guide](https://docs.flutter.dev/get-started/install).
    - Verify installation:
      ```bash
      flutter doctor
      ```

2. **Clone the Repository**
   ```bash
   git clone <(https://github.com/benji181/mykobiassessment.git)>
   cd lib
   ```

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the App**
   ```bash
   flutter run
   ```

> Use a physical device or the AOSP on IA emulator. If you get an SDK XML version warning, update Android SDK Command-line Tools via Android Studio.

## 📦 Libraries Used

- `flutter_riverpod: ^2.3.6` – State management
- `http: ^1.1.0` – Placeholder for potential API integration
- `flutter_spinkit: ^5.2.0` – Loading animations (not used in final build)
- `fl_chart: ^0.63.0` – Circular expense chart
- `intl: ^0.18.0` – Date formatting

## 🎨 Design and State Management Decisions

### Design
- Rounded Netflix logos using `CircleAvatar` with a subtle 1px border.
- Responsive UI using `SingleChildScrollView` and `ListView.builder`.
- Fade-in animations for transactions via a custom `FadeInAnimation` widget.
- Platform-specific UI tweaks (AppBar elevation: 0 for iOS, 4 for Android).
- UI styled to prototype: orange for amounts, blue for status.

### State Management
- Used Riverpod for its simplicity and scalability.
- `transactionProvider` manages transaction data from a mock JSON file.
- Refund status updates are persisted in app state.
- UI reactively updates using `ConsumerWidget` and `ConsumerStatefulWidget`.

## 🔌 API Simulation

The app simulates API behavior by loading transaction data from a local JSON file (`assets/transactions.json`). It mimics an actual API response using `DefaultAssetBundle` to load and parse transaction objects at runtime. This allows realistic testing without backend dependency.

## 🎥 Demo Video

> ** Video Link**: [assets/demoVideo.mp4]

### What’s shown in the video:
- Transaction list loads with animations.
- Navigating to transaction detail screen.
- Refund functionality with UI and status change.
- Returning to summary page to confirm persistent update.


**Demo Video**: [assets/demoVideo.mp4]
