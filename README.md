# 🚀 App Starter Kit (MVVM + SwiftData)

<div align="center">

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![Xcode](https://img.shields.io/badge/Xcode-15.0+-blue.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-green.svg)
![SwiftData](https://img.shields.io/badge/SwiftData-1.0-purple.svg)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)

**A production-ready iOS project scaffold with MVVM architecture, SwiftData persistence, theming, and utilities.**

[Features](#-features) • [Installation](#-installation) • [Quick Start](#-quick-start) • [Documentation](#-documentation) • [Contributing](#-contributing)

</div>

---

## 📋 Table of Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Installation](#-installation)
- [Quick Start](#-quick-start)
- [Project Structure](#-project-structure)
- [Documentation](#-documentation)
- [Requirements](#-requirements)
- [Contributing](#-contributing)
- [License](#-license)

## ✨ Features

- ✅ **Clean Architecture** - MVVM pattern with separation of concerns
- ✅ **SwiftData Integration** - Modern persistence with `@Model`, CRUD operations, and previews
- ✅ **Theme System** - Comprehensive design tokens (Colors, Typography, Spacing)
- ✅ **Dependency Injection** - Environment-based DI pattern for testability
- ✅ **Error Handling** - Custom `AppError` enum and `Result` type extensions
- ✅ **AppStorage Examples** - User preferences and settings management
- ✅ **Unit Tests** - Sample test suite for models, ViewModels, and services
- ✅ **Production Ready** - Well-structured, documented, and scalable codebase

## 📸 Screenshots

> Add screenshots of your app here

## 🛠 Installation

### Prerequisites

- macOS 14.0 or later
- Xcode 15.0 or later
- iOS 17.0+ deployment target

### Clone the Repository

```bash
git clone https://github.com/SabbirHossain07/AppStarterKit-MVVM-SwiftData.git
cd AppStarterKit-MVVM-SwiftData
```

### Open in Xcode

1. Open `AppStarterKit(MVVM+SwiftData).xcodeproj` in Xcode
2. Select your development team in Signing & Capabilities
3. Build and run (⌘R)

## 🚀 Quick Start

### 1. Run the App

The project includes a working Counter feature that demonstrates:
- SwiftData persistence
- MVVM architecture
- Theme system usage
- AppStorage integration

Simply build and run to see it in action!

### 2. Add Your First Model

```swift
import SwiftData

@Model
final class Task {
    var id: UUID
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
        self.createdAt = Date()
    }
}
```

### 3. Register in PersistenceController

```swift
let schema = Schema([
    Counter.self,
    Task.self  // Add your model here
])
```

### 4. Create ViewModel

```swift
@MainActor
final class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadTasks()
    }
    
    func loadTasks() {
        let descriptor = FetchDescriptor<Task>()
        tasks = (try? modelContext.fetch(descriptor)) ?? []
    }
}
```

## 📁 Project Structure

```
AppStarterKit(MVVM+SwiftData)/
├── App/
│   └── AppStarterKit_MVVM_SwiftData_App.swift  # App entry point
│
├── Models/
│   └── Counter.swift                            # SwiftData model example
│
├── ViewModels/
│   └── CounterViewModel.swift                  # MVVM ViewModel
│
├── Views/
│   ├── ContentView.swift                        # Main content view
│   ├── CounterView.swift                       # Counter feature view
│   └── AppStorageExamples.swift                # AppStorage examples
│
├── Services/
│   └── APIService.swift                         # API service protocol
│
├── Utils/
│   ├── Extensions.swift                         # Common extensions
│   ├── Result+Extensions.swift                  # Error handling
│   └── AppEnvironment.swift                     # Dependency Injection
│
├── Theme/
│   ├── AppColors.swift                          # Color tokens
│   ├── AppTypography.swift                     # Typography tokens
│   └── AppSpacing.swift                        # Spacing tokens
│
└── Persistence/
    └── PersistenceController.swift             # SwiftData container
```

## 📚 Documentation

### SwiftData Setup

The app is pre-configured with SwiftData. The `PersistenceController` manages the `ModelContainer`:

```swift
let persistenceController = PersistenceController.shared
```

**Adding New Models:**
1. Create a Swift file in `Models/` with `@Model` macro
2. Add to schema in `PersistenceController.swift`

### MVVM Pattern

**Model:**
```swift
@Model
final class YourModel {
    var id: UUID
    var name: String
}
```

**ViewModel:**
```swift
@MainActor
final class YourViewModel: ObservableObject {
    @Published var items: [YourModel] = []
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}
```

**View:**
```swift
struct YourView: View {
    @StateObject private var viewModel: YourViewModel
    @Environment(\.modelContext) private var modelContext
    
    init() {
        _viewModel = StateObject(wrappedValue: YourViewModel(modelContext: modelContext))
    }
}
```

### Theme System

**Colors:**
```swift
Text("Hello")
    .foregroundColor(AppColors.defaultPrimary)
```

**Typography:**
```swift
Text("Title")
    .appTypography(AppTypography.headlineLarge)
```

**Spacing:**
```swift
VStack {
    // Content
}
.padding(AppSpacing.md)
```

### Dependency Injection

Services are injected via Environment:

```swift
struct YourView: View {
    @Environment(\.apiService) var apiService
    
    var body: some View {
        // Use apiService
    }
}
```

### Error Handling

```swift
func fetchData() async -> Result<Data, AppError> {
    // Your async operation
    return .success(data)
    // or
    return .failure(.networkError("Failed"))
}

// Usage
let result = await fetchData()
switch result {
case .success(let data):
    // Handle success
case .failure(let error):
    // Handle error
    print(error.localizedDescription)
}
```

### Running Tests

1. Create a test target in Xcode (if not exists)
2. Add test files to the test target
3. Run tests with `⌘U` or:

```bash
xcodebuild test -scheme "AppStarterKit(MVVM+SwiftData)"
```

## 📋 Requirements

- **iOS:** 17.0+
- **Xcode:** 15.0+
- **Swift:** 5.9+
- **macOS:** 14.0+ (for development)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- Powered by [SwiftData](https://developer.apple.com/documentation/swiftdata)
- Inspired by clean architecture principles

## 📞 Support

If you have any questions or need help, please:
- Open an [Issue](https://github.com/SabbirHossain07/AppStarterKit-MVVM-SwiftData/issues)
- Check the [Documentation](#-documentation) section
- Review the code examples in the project

---

<div align="center">

**Made with ❤️ using SwiftUI and SwiftData**

⭐ Star this repo if you find it helpful!

</div>
