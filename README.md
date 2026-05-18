# DeltaGames iOS

[![iOS CI](https://github.com/deltarfd/DeltaGamesiOS/actions/workflows/ios-ci.yml/badge.svg)](https://github.com/deltarfd/DeltaGamesiOS/actions/workflows/ios-ci.yml)
[![Security and Dependencies](https://github.com/deltarfd/DeltaGamesiOS/actions/workflows/security-and-deps.yml/badge.svg)](https://github.com/deltarfd/DeltaGamesiOS/actions/workflows/security-and-deps.yml)

DeltaGames is a modern iOS game discovery application built with SwiftUI and powered by the RAWG API. This repository showcases a clean, modular architecture with clear separation between presentation, domain, data, and persistence layers, plus reusable feature modules for Home, Detail, Favorite, Search, and Profile. It is designed as both a production-ready app foundation and a learning reference for scalable iOS development, including unit tests, CI automation, linting, and secure API key handling.


## Submission Result

![Submission Result](docs/SubmissionResult.png)

## Course Certificate

- https://www.dicoding.com/certificates/98XW08R44XM3

## Prototype

[![Open in Figma](https://img.shields.io/badge/Figma-Open%20Wireframe%20Design-F24E1E?logo=figma&logoColor=white)](https://www.figma.com/design/NnC0lsVvTqmuX5Ikvbmuor/Delta-Games---DICODING-2026-Updated?node-id=0-1&t=HlXVOVsqxpOlRHch-1)

[View Wireframe Design](https://www.figma.com/design/NnC0lsVvTqmuX5Ikvbmuor/Delta-Games---DICODING-2026-Updated?node-id=0-1&t=HlXVOVsqxpOlRHch-1)

![Wireframe](docs/Wireframe.png)

## Screenshots

<table>
  <tr>
    <td align="center" width="50%"><img src="docs/HomeScreen.png" alt="Home Screen" width="220" /><br/><sub>Home</sub></td>
    <td align="center" width="50%"><img src="docs/SearchScreen.png" alt="Search Screen" width="220" /><br/><sub>Search</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/GameDetailScreen.png" alt="Game Detail Screen" width="220" /><br/><sub>Detail</sub></td>
    <td align="center"><img src="docs/FavoriteScreen.png" alt="Favorite Screen" width="220" /><br/><sub>Favorite</sub></td>
  </tr>
  <tr>
    <td align="center" colspan="2"><img src="docs/ProfileScreen.png" alt="Profile Screen" width="220" /><br/><sub>Profile</sub></td>
  </tr>
</table>
## App Overview

- Discover games from the RAWG API with a fast, clean SwiftUI experience.
- Browse game lists on the Home page and search titles by keyword.
- Open a detail page to see game information and supporting visuals.
- Save favorites for quick access later.
- View developer/profile information in the Profile page.

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
