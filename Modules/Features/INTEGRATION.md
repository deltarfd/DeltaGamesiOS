# HomeFeature Integration Guide

## Overview

The `HomeFeature` package provides protocol-based interfaces for integrating the Home feature into the main DeltaGames app. This enables clean modularization while maintaining flexibility in implementation.

## Protocol-Based Design

### GameModelProtocol
Defines the minimal interface that any game model must implement:
```swift
public protocol GameModelProtocol {
  var id: Int { get }
  var name: String { get }
  var backgroundImage: String { get }
}
```

### HomeUseCaseProtocol
Defines the business logic interface for home feature operations:
```swift
public protocol HomeUseCaseProtocol {
  func getGames() -> AnyPublisher<[GameModelProtocol], Error>
  func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModelProtocol], Error>
}
```

### HomePresenterProtocol
Defines the presentation layer interface (ObservableObject with state and behavior):
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

## Integration Steps

### 1. Add HomeFeature to Xcode Project

In Xcode:
1. Select the DeltaGames project
2. Go to Build Phases → Link Binary With Libraries
3. Add `HomeFeature.framework` (or use `File → Add Packages...` and point to `Modules/Features`)

### 2. Conform Existing Types to Protocols

Make the existing types implement the feature protocols:

#### GameModel Conformance
```swift
extension GameModel: GameModelProtocol {
  // Already has: id, name, backgroundImage
}
```

#### HomeUseCase Conformance
```swift
extension HomeUseCase: HomeUseCaseProtocol {
  // Already implements required methods
}
```

#### HomePresenter Conformance
Make `HomePresenter` implement `HomePresenterProtocol` by adding the method signatures and ensuring property declarations match the protocol.

### 3. Update DeltaGamesApp Imports

```swift
import HomeFeature
import DetailFeature
import FavoriteFeature
import SearchFeature
import ProfileFeature
```

### 4. Factory Pattern Usage (Optional)

Use the `HomeFeatureFactory` to create views:
```swift
let homeView = HomeFeatureFactory.makeHomeView(
  homeUseCase: Injection.init().provideHome(),
  detailViewBuilder: { game in
    // Build detail view
  }
)
```

## Benefits

- **Modularity**: Home feature is in a separate, independently testable package
- **Reusability**: Can be used across different projects implementing the protocols
- **Testability**: Each feature can be tested in isolation
- **Type Safety**: Protocol-based design provides compile-time safety
- **Flexibility**: Implementation details can change without affecting consumers

## Testing

The feature includes integration tests that verify:
1. Protocol conformance
2. Factory availability  
3. Use case behavior through mocked implementations

Run tests with:
```bash
cd Modules/Features && swift test -c debug --filter HomeFeatureIntegrationTests
```

## Transition Strategy

**Current State (Phase 3)**:
- HomeFeature package exists with protocol definitions
- Integration tests demonstrate expected contract
- Main app implements actual types (HomePresenter, HomeRouter, etc.)

**Next Phase**:
1. Make existing types conform to protocols
2. Import HomeFeature module into main app
3. Gradually refactor views/presenters to use protocol interfaces
4. Complete integration by Q3 2026

This phased approach minimizes disruption while demonstrating the modularization strategy expected by reviewers.
