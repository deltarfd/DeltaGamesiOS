# CoreCommon

Generic protocols and helpers for Swift iOS development.

[![Swift](https://img.shields.io/badge/Swift-5.9%2B-orange)]()
[![iOS](https://img.shields.io/badge/iOS-14.0%2B-blue)]()
[![macOS](https://img.shields.io/badge/macOS-12.0%2B-brightgreen)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Features

- **UseCase Protocol**: Generic `UseCase<Request, Response>` for synchronous business logic
- **AsyncUseCase Protocol**: Async/await variant for modern asynchronous patterns
- **Localization**: Multi-language support with fallback (English, Indonesian, extensible)
- **NoRequest Enum**: Type-safe marker for use cases that don't require parameters

## Installation

### Swift Package Manager
Add to `Package.swift`:

```swift
.package(url: "https://github.com/deltarfd/DeltaGamesiOS-CoreCommon.git", from: "1.0.1")
```

In Xcode:
1. File → Add Packages
2. Enter repository URL
3. Select version and add to target

## Usage

### UseCase Pattern

Synchronous use case:

```swift
import CoreCommon

struct FetchGamesRequest {
  let genre: String
}

struct FetchGamesResponse {
  let games: [Game]
}

class FetchGamesUseCase: UseCase {
  typealias Request = FetchGamesRequest
  typealias Response = FetchGamesResponse
  
  func execute(_ request: Request) throws -> Response {
    // Business logic implementation
    return FetchGamesResponse(games: [])
  }
}

// Usage
let useCase = FetchGamesUseCase()
let request = FetchGamesRequest(genre: "Action")
let response = try useCase.execute(request)
```

Use case without parameters:

```swift
class RefreshCacheUseCase: UseCase {
  typealias Request = NoRequest
  typealias Response = String
  
  func execute(_ request: NoRequest) throws -> String {
    // Execute without parameters
    return "Cache refreshed"
  }
}

// Usage
let useCase = RefreshCacheUseCase()
let response = try useCase.execute(.value)
```

Async use case (Swift 5.5+):

```swift
class AsyncFetchGamesUseCase: AsyncUseCase {
  typealias Request = String  // Genre
  typealias Response = [Game]
  
  func execute(_ request: String) async throws -> [Game] {
    // Async implementation
    return []
  }
}

// Usage
async {
  let useCase = AsyncFetchGamesUseCase()
  let games = try await useCase.execute("RPG")
}
```

### Localization

Get localized strings with fallback support:

```swift
import CoreCommon

// Uses device locale (en, id, etc.) with English fallback
let localizedText = CommonLocalization.localized("app_title")

// Explicit bundle parameter (defaults to .module)
let customText = CommonLocalization.localized("key", bundle: .main)
```

Supported languages:
- **en**: English (English.lproj/Localizable.strings)
- **id**: Indonesian (Indonesian.lproj / OpenDictionary/Localizable.strings)

To add more languages:
1. Create new `.lproj` folder in Resources (e.g., `es.lproj`)
2. Add `Localizable.strings` with key-value pairs
3. Update `CommonLocalization.swift` if needed

## Architecture

### Protocol-Based Design

All protocols are designed for injection and testing:

```
UseCase Protocol (Generic)
    ↓
Specific Implementation (FetchGamesUseCase)
    ↓
Presenter/ViewModel
    ↓
View (SwiftUI)
```

This enables:
- ✅ Easy unit testing with mock implementations
- ✅ Dependency injection for flexibility
- ✅ Loose coupling between layers

### Testing

Comprehensive test coverage included:

```bash
cd Modules/CoreCommon
swift test
```

Tests cover:
- UseCase execution with various request/response types
- NoRequest equatability
- Localization fallback behavior
- Existing translation resolution

Run specific test:

```bash
swift test --filter UseCaseTests
swift test --filter LocalizationTests
```

## Requirements

- **Swift**: 5.9+
- **iOS**: 14.0+
- **macOS**: 12.0+

## Platform Support

Targets:
- iOS 14.0 or later
- macOS 12.0 or later

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## Support

For issues and feature requests, please use GitHub Issues.

## Changelog

### 1.0.1
- Documentation updates and corrections
- Updated package repository URL examples
- Removed Features repository reference from Related Projects

### 1.0.0 (Initial Release)
- Generic UseCase protocol (sync)
- AsyncUseCase protocol (async/await)
- Localization helper with en/id support
- NoRequest type for parameterless use cases
- Comprehensive test suite

## Related Projects

- [DeltaGames](https://github.com/deltarfd/DeltaGamesiOS) - Main iOS application using CoreCommon

## Authors

- **Delta Rahmat Fajar Delviansyah** - Initial work

---

## Quick Start

```swift
// 1. Add to Package.swift
.package(url: "https://github.com/deltarfd/DeltaGamesiOS-CoreCommon.git", from: "1.0.1")

// 2. Import and use
import CoreCommon

// 3. Create a use case
class MyUseCase: UseCase {
  typealias Request = String
  typealias Response = Int
  
  func execute(_ request: String) throws -> Int {
    return request.count
  }
}

// 4. Use it
let result = try MyUseCase().execute("Hello")  // Returns 5
```

For detailed examples, see [docs/corecommon-publishing-guide.md](../docs/corecommon-publishing-guide.md).
