# DeltaGames iOS

DeltaGames is a SwiftUI iOS app for discovering game data from RAWG API with favorite management and profile features.

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

- **For CI/CD (main repo)**: Set `RAWG_API_KEY` secret in GitHub Actions or `CODEMAGIC_BUILD_RAWG_API_KEY` in Codemagic for full coverage data.
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
