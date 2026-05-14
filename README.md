# DeltaGames iOS

[![iOS CI](https://github.com/deltarfd/DeltaGamesiOS/actions/workflows/ios-ci.yml/badge.svg)](https://github.com/deltarfd/DeltaGamesiOS/actions/workflows/ios-ci.yml)
[![Security and Dependencies](https://github.com/deltarfd/DeltaGamesiOS/actions/workflows/security-and-deps.yml/badge.svg)](https://github.com/deltarfd/DeltaGamesiOS/actions/workflows/security-and-deps.yml)

DeltaGames is a SwiftUI iOS app for discovering game data from RAWG API with favorite management and profile features.

## Prototype

<a href="https://www.figma.com/proto/NnC0lsVvTqmuX5Ikvbmuor/Delta-Games---DICODING-2026-Updated?node-id=0-1&t=HlXVOVsqxpOlRHch-1" target="_blank" rel="noopener noreferrer">
  <img src="https://img.shields.io/badge/Figma-View%20Interactive%20Prototype-F24E1E?logo=figma&logoColor=white" alt="Open Figma Prototype" />
</a>

<a href="https://www.figma.com/proto/NnC0lsVvTqmuX5Ikvbmuor/Delta-Games---DICODING-2026-Updated?node-id=0-1&t=HlXVOVsqxpOlRHch-1">View Interactive Prototype</a>

## Screenshots

<img src="docs/HomeScreen.png" alt="Home Screen" width="220" />
<img src="docs/SearchScreen.png" alt="Search Screen" width="220" />
<img src="docs/GameDetailScreen.png" alt="Game Detail Screen" width="220" />
<img src="docs/FavoriteScreen.png" alt="Favorite Screen" width="220" />
<img src="docs/ProfileScreen.png" alt="Profile Screen" width="220" />

## Submission Readiness Highlights

- Clean Architecture layering: Data, Domain, Presentation.
- Dependency Injection through centralized composition root.
- Reactive programming approach using Combine.
- Feature pages available: Home, Detail, Favorite, and Profile (About).
- Continuous Integration with GitHub Actions (graceful handling for fork PRs).
- Coverage reporting via Codecov with LCOV format.
- Additional mobile pipeline with Codemagic.
- SwiftLint enabled for style and code convention checks.
- Business logic test package with XCTest in CoreCommon module.
- Feature module packages (Home, Detail, Favorite, Search, Profile) prepared as independent frameworks.
- **Security**: API key managed via CI/CD environment variables (not in source code).

## API Key Configuration

The RAWG API key is managed securely through environment variables:

- **For CI/CD (main repo)**: Set `RAWG_API_KEY` secret in GitHub Actions or `RAWG_API_KEY` in Codemagic for full coverage data.
- **For Fork PRs**: CI automatically uses a non-secret fallback key; build/tests run without external API data.
- **For Local Development**: Set `RAWG_API_KEY` env variable or update `RawgAPI.plist`

## Build Locally

### 1) Install dependencies

```bash
pod install --repo-update
```

### 2) Build app

```bash
xcodebuild \
  -workspace DeltaGames.xcworkspace \
  -scheme DeltaGames \
  -destination 'generic/platform=iOS Simulator' \
  -configuration Debug \
  clean build
```

### 3) Run lint

```bash
./Pods/SwiftLint/swiftlint lint --config .swiftlint.yml DeltaGames
```

## Repository Structure

- `DeltaGames/`: Main iOS application.
- `Modules/CoreCommon/`: Common reusable module (generic protocols + localization + tests).
- `Modules/Features/`: Feature framework modules (Home, Detail, Favorite, Search, Profile).
- `.github/workflows/`: CI and security automation.
- `codemagic.yaml`: Codemagic build pipeline.
