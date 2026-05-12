# DeltaGames Features

Reusable feature modules for the DeltaGames iOS application, providing a modular architecture with protocol-based interfaces for clean integration.

## Overview

The Features package contains 5 independent feature modules:

- **HomeFeature** — Display trending and all games with reactive data flow
- **DetailFeature** — Show comprehensive game details with favorite toggle
- **FavoriteFeature** — Manage user's favorite games with local persistence
- **SearchFeature** — Search and filter games by name with live results
- **ProfileFeature** — User profile management and language/theme settings

## Features

✅ **Modular Architecture** — Each feature is independently testable and reusable  
✅ **Protocol-Based** — Clean integration via public protocols, not concrete types  
✅ **Reactive Programming** — Built with Combine for responsive, predictable data flows  
✅ **Generic Patterns** — Uses CoreCommon's `UseCase` protocol for DRY business logic  
✅ **Comprehensive Testing** — 39+ unit and integration tests, 100% passing  
✅ **Zero Coupling** — Features don't depend on main app; only vice versa  

## Requirements

- **iOS** 14.0+
- **Swift** 5.9+
- **Xcode** 15.0+

## Installation

### Swift Package Manager (Recommended)

#### Option 1: Using Xcode
1. In Xcode: **File → Add Packages**
2. Enter: `https://github.com/deltarfd/DeltaGamesiOS-Features.git`
3. Select version: `1.0.0` or later
4. Choose targets to add to (optional for now, or just add to main app)
5. Click **Add Package**

#### Option 2: Edit Package.swift
```swift
dependencies: [
  .package(url: "https://github.com/deltarfd/DeltaGamesiOS-Features.git", from: "1.0.0")
],
targets: [
  .target(
    name: "YourApp",
    dependencies: [
      .product(name: "HomeFeature", package: "DeltaGamesiOS-Features"),
      .product(name: "DetailFeature", package: "DeltaGamesiOS-Features"),
      .product(name: "FavoriteFeature", package: "DeltaGamesiOS-Features"),
      .product(name: "SearchFeature", package: "DeltaGamesiOS-Features"),
      .product(name: "ProfileFeature", package: "DeltaGamesiOS-Features")
    ]
  )
]
```

### Dependencies

The Features package has **one required dependency**:

- **CoreCommon** `1.0.1+` — https://github.com/deltarfd/DeltaGamesiOS-CoreCommon
  - Provides: Generic `UseCase` and `AsyncUseCase` protocols
  - Provides: Multi-language `CommonLocalization` helpers (en, id)
  - Automatically resolved via Package.swift

## Usage

### Importing Features

```swift
import HomeFeature
import DetailFeature
import FavoriteFeature
import SearchFeature
import ProfileFeature
```

### Building Views

Each feature exports a factory for creating views:

```swift
// Home
let homeView = HomeFeatureFactory.makeHomeView(
  homeUseCase: homeUseCase,
  detailViewBuilder: { game in AnyView(DetailView(...)) }
)

// Others have similar patterns
```

### Protocol-Based Integration

For maximum flexibility, each feature exports public protocols:

#### GameModelProtocol
```swift
public protocol GameModelProtocol {
  var id: Int { get }
  var name: String { get }
  var backgroundImage: String { get }
}
```

#### HomeUseCaseProtocol
```swift
public protocol HomeUseCaseProtocol {
  func getGames() -> AnyPublisher<[GameModelProtocol], Error>
  func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModelProtocol], Error>
}
```

#### HomePresenterProtocol
```swift
public protocol HomePresenterProtocol: ObservableObject {
  var trending: [GameModelProtocol] { get }
  var games: [GameModelProtocol] { get }
  var errorMessage: String { get }
  var loadingTrending: Bool { get }
  var loadingGames: Bool { get }
  
  func getGames()
  func getTrending(ordering: String, discover: String)
}
```

This allows you to:
- Mock implementations for testing
- Swap concrete implementations without changing app code
- Share data models across features

### Integration Testing

Each feature includes integration tests demonstrating protocol conformance:

```swift
// Test that protocols work together
let mockUseCase = MockHomeUseCase()
let view = HomeFeatureFactory.makeHomeView(
  homeUseCase: mockUseCase,
  detailViewBuilder: { _ in AnyView(EmptyView()) }
)
// Verify view builds successfully with mock dependencies
```

## Architecture

### Module Structure

```
Features/
├── Sources/
│   ├── HomeFeature/
│   │   ├── HomeFeatureContract.swift (public entry point)
│   │   └── HomePresenter.swift (protocols + implementation)
│   ├── DetailFeature/
│   ├── FavoriteFeature/
│   ├── SearchFeature/
│   └── ProfileFeature/
├── Tests/
│   ├── HomeFeatureTests/
│   │   ├── HomeFeatureContractTests.swift
│   │   ├── HomeFeatureIntegrationTests.swift
│   │   └── HomePresenterProtocolTests.swift
│   ├── SearchFeatureTests/
│   └── ... (similar for all features)
├── Package.swift
└── README.md (this file)
```

### Dependency Graph

```
App
├── HomeFeature ─┐
├── DetailFeature ├─→ CoreCommon (1.0.1+)
├── FavoriteFeature
├── SearchFeature ┤
└── ProfileFeature ┘
```

**Note**: Features package has **zero external dependencies** except CoreCommon. No Alamofire, Realm, etc. — those are in the main app layer.

## Testing

### Run All Tests

```bash
swift test
```

### Run Specific Feature Tests

```bash
swift test --filter HomeFeatureTests
swift test --filter SearchFeatureTests
# etc.
```

### Test Coverage

- **39+ tests** covering:
  - ✅ Protocol conformance
  - ✅ Use case execution (success, failure, empty states)
  - ✅ Factory pattern
  - ✅ Integration scenarios
  - ✅ Error handling

- **100% test pass rate**

## Version History

### 1.0.0 (May 12, 2026)
- Initial release with 5 feature modules
- Protocol-based architecture for clean separation
- Reactive programming with Combine
- Integration with CoreCommon 1.0.1+
- Comprehensive test coverage (39+ tests)
- Zero external dependencies (only CoreCommon)

## Features in Detail

### HomeFeature
Displays trending games and all available games with reactive loading states.

**Protocols**:
- `GameModelProtocol` — Minimal game interface
- `HomeUseCaseProtocol` — Business logic
- `HomePresenterProtocol` — Presentation (ObservableObject)
- `HomeFeatureFactory` — View creation

**Features**:
- ✅ Trending games carousel (horizontal scroll)
- ✅ All games grid (vertical scroll)
- ✅ Loading indicators
- ✅ Error handling with messages
- ✅ Navigation to detail view

### DetailFeature
Shows comprehensive game information with favorite toggle.

**Features**:
- ✅ Large game image
- ✅ Rating display with stars
- ✅ Genres, platforms, tags
- ✅ Release date and rating count
- ✅ Favorite button with heart animation
- ✅ Loading state during data fetch

### FavoriteFeature
Manages and displays saved favorite games.

**Features**:
- ✅ Grid layout of favorites
- ✅ Empty state message
- ✅ Real-time updates (via NotificationCenter)
- ✅ Refresh on screen appear
- ✅ Easy access from other features

### SearchFeature
Real-time game search with debouncing.

**Features**:
- ✅ Live search as user types
- ✅ Debounced queries (0.35s delay)
- ✅ Empty state messages
- ✅ Loading indicator
- ✅ Results grid layout

### ProfileFeature
User profile and app settings.

**Features**:
- ✅ Language selection (System, English, Indonesian)
- ✅ Profile information editing
- ✅ Hero section with avatar
- ✅ Settings panel
- ✅ Dark mode support

## Best Practices

### ✅ Do
- Use public protocols for integration
- Implement error handling in your presenter/use case
- Test with mock implementations
- Keep business logic in use cases, UI in presenters
- Use CoreCommon's `UseCase` protocol pattern

### ❌ Don't
- Modify feature implementations (they're standalone)
- Import private classes (only use public exports)
- Bypass factories (use `makeView()` methods)
- Couple your app directly to feature implementations

## Common Patterns

### Dependency Injection

```swift
// Inject dependencies when creating features
let homeView = HomeFeatureFactory.makeHomeView(
  homeUseCase: myHomeInteractor,  // Your implementation
  detailViewBuilder: { game in
    AnyView(DetailView(presenter: detailPresenter))
  }
)
```

### Error Handling

Features handle errors gracefully:

```swift
// Errors are captured in presenter
@Published var errorMessage: String = ""

// Display to user
if !presenter.errorMessage.isEmpty {
  Text(presenter.errorMessage)
}
```

### Loading States

Every feature has loading states:

```swift
@Published var loadingTrending: Bool = false
@Published var loadingGames: Bool = false

// Use in UI
if presenter.loadingTrending {
  ProgressView()
} else {
  trendingGamesView
}
```

## Troubleshooting

### Issue: "No such module 'HomeFeature'"

**Solution**: Ensure you've added Features package to target:
```bash
# Check Package.swift has Features dependency
# Check target lists HomeFeature in dependencies
swift package update
```

### Issue: "Protocol conformance type mismatch"

**Solution**: Use protocol types, not concrete types:
```swift
// ✅ Correct
func acceptGame(_ game: GameModelProtocol)

// ❌ Wrong
func acceptGame(_ game: GameModel)
```

### Issue: Tests not importing CoreCommon

**Solution**: Use `@testable import`:
```swift
import CoreCommon  // Public protocols
@testable import CoreCommon  // For testing internals
```

## Performance

- **Build time**: ~15-20s (first time), ~5s (incremental)
- **Test suite**: ~2-3s
- **Runtime overhead**: Minimal (protocol dispatch only)

## Migration Guide (from local to git)

If updating from local Features folder to published package:

```bash
# Remove local copy from workspace
rm -rf Modules/Features  # (after backing up)

# Add via Package Manager
# File → Add Packages → https://github.com/deltarfd/DeltaGamesiOS-Features.git
```

## Contributing & Issues

This package is part of the DeltaGames project. For:
- **Bug reports**: GitHub Issues (main repo)
- **Feature requests**: GitHub Discussions
- **Pull requests**: Welcome!

## License

MIT License — See LICENSE file in repository

## Related Packages

- **CoreCommon** — https://github.com/deltarfd/DeltaGamesiOS-CoreCommon
  - Generic protocols and helpers
  - Required dependency

## Author

Delta Rahmat Fajar Delviansyah

---

## Quick Start Checklist

- [ ] Add Features package to your project
- [ ] Import desired feature modules
- [ ] Use factories to create views
- [ ] Pass dependencies (use cases, routers)
- [ ] Handle loading and error states
- [ ] Test with mock implementations

**That's it! You're ready to use enterprise-grade modular features. 🚀**
