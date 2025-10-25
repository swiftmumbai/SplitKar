# SplitKar

A SwiftUI-based iOS application for managing and splitting expenses.

## Table of Contents
- [Requirements](#requirements)
- [Tech Stack](#tech-stack)
- [Project Setup](#project-setup)
- [Project Structure](#project-structure)
- [Running the App](#running-the-app)
- [Architecture](#architecture)
- [Contributing](#contributing)
- [License](#license)

## Requirements

- **macOS**: macOS 14.0 (Sonoma) or later
- **Xcode**: Version 15.0 or later
- **iOS Deployment Target**: iOS 17.0 or later
- **Swift**: Swift 5.9 or later

## Tech Stack

- **SwiftUI** - Modern declarative UI framework
- **SwiftData** - Persistent data storage (iOS 17.0+)
- **iCloud (CloudKit)** - Automatic sync across devices
- **Native iOS Colors** - System colors with automatic light/dark mode
- **MVVM Architecture** - Clean separation of concerns

## Project Setup

### 1. Clone the Repository

```bash
git clone https://github.com/Swift-Mumbai/SplitKar.git
cd SplitKar
```

**Note**: The project uses two main branches:
- `main` - Stable production-ready code
- `develop` - Active development branch

To work on the latest features, switch to the develop branch:

```bash
git checkout develop
```

### 2. Open the Project

Open the project in Xcode:

```bash
open SplitKar.xcodeproj
```

Alternatively, you can:
- Launch **Xcode**
- Select **File → Open**
- Navigate to the `SplitKar.xcodeproj` file and open it

### 3. Select a Target Device

In Xcode:
1. Click on the **device selector** in the toolbar (next to the scheme selector)
2. Choose either:
   - A **physical iOS device** (iPhone/iPad running iOS 17.0+)
   - A **simulator** (iPhone 15, iPhone 14, etc.)

### 4. Configure Signing & iCloud (Required)

**For all devices (simulator and physical):**

1. Select the **SplitKar** project in the Project Navigator
2. Select the **SplitKar** target
3. Go to the **Signing & Capabilities** tab
4. Check **Automatically manage signing**
5. Select your **Team** from the dropdown
   - If you don't see a team, you'll need to add your Apple ID in Xcode:
     - **Xcode → Settings → Accounts → + → Apple ID**

**Enable iCloud Sync:**

6. In the same **Signing & Capabilities** tab, click **+ Capability**
7. Add **iCloud**
8. Check **CloudKit**
9. The CloudKit container should be auto-configured

**Note:** iCloud sync requires you to be signed in with an Apple ID on your device/simulator.

## Project Structure

```
SplitKar/
├── SplitKar/
│   ├── SplitKarApp.swift      # App entry point
│   ├── ContentView.swift      # Main view
│   ├── Item.swift             # SwiftData model
│   └── Assets.xcassets/       # App assets and icons
├── SplitKar.xcodeproj/        # Xcode project file
├── README.md                   # This file
└── LICENSE                     # MIT License
```

## Running the App

### Using Xcode

1. **Build the project**: `⌘ + B`
2. **Run the app**: `⌘ + R`
3. The app will launch on your selected simulator or device

### Using Command Line

```bash
# Build the project
xcodebuild -project SplitKar.xcodeproj -scheme SplitKar -configuration Debug build

# Run on a specific simulator
xcodebuild -project SplitKar.xcodeproj -scheme SplitKar -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest' test
```

## Architecture

The project follows **MVVM (Model-View-ViewModel)** architecture:

- **Model**: SwiftData models (`Item.swift`)
- **View**: SwiftUI views (`ContentView.swift`)
- **ViewModel**: Business logic layer (to be implemented)

### Key Technologies

- **SwiftData**: Used for persistent data storage with a declarative API
- **iCloud Sync**: Automatic CloudKit sync across all user devices
- **NavigationSplitView**: Adaptive navigation for iPhone and iPad
- **ModelContext**: Environment object for managing SwiftData operations
- **Native iOS Colors**: System colors that automatically adapt to light/dark mode
- **Dynamic Type**: Full support for iOS accessibility features

## Development Guidelines

- Minimum deployment target: **iOS 17.0**
- Use **native iOS system colors** (Color.purple, Color.blue, etc.) for automatic light/dark mode
- Follow **Swift's official style guidelines**
- Use **value types** (structs) over reference types when possible
- Avoid force unwrapping - use safe unwrapping (`if let`, `guard let`)
- Support **Dynamic Type** for accessibility
- Write **unit tests** for ViewModels and business logic

## Troubleshooting

### Common Issues

**Build Failed - "Could not create ModelContainer"**
- Ensure you're running on iOS 17.0+ simulator/device (SwiftData requirement)
- Check that your deployment target is set to iOS 17.0 or later

**Code Signing Error**
- Make sure you've selected a development team in Signing & Capabilities
- Ensure your Apple ID is added in Xcode Settings → Accounts

**Simulator Not Launching**
- Restart Xcode
- Reset the simulator: **Device → Erase All Content and Settings**
- Check that you have sufficient disk space

**iCloud Sync Not Working**
- Ensure you're signed in with an Apple ID on the device/simulator
- Check that iCloud capability is enabled in **Signing & Capabilities**
- Verify CloudKit container is configured correctly
- Go to **Settings → Apple ID → iCloud** and ensure iCloud Drive is enabled
- For simulators, you may need to sign in through Settings app first

### Getting Help

If you encounter issues:
1. Check the [Issues](https://github.com/Swift-Mumbai/SplitKar/issues) page
2. Create a new issue with detailed information about your problem
3. Include Xcode version, iOS version, and error messages

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Clone your fork and checkout the `develop` branch:
   ```bash
   git checkout develop
   ```
3. Create a branch from `develop`:
   - For new features:
     ```bash
     git checkout -b feature/amazing-feature
     ```
   - For bug fixes:
     ```bash
     git checkout -b bugfix/fix-issue-description
     ```
4. Commit your changes (`git commit -m 'Add amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request against the `develop` branch (not `main`)

**Branch Strategy**:
- `main` - Production-ready releases only
- `develop` - Integration branch for features (base all PRs on this branch)
- `feature/*` - New features and enhancements
- `bugfix/*` - Bug fixes for issues found in development

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Made with ❤️ by Swift Mumbai**
