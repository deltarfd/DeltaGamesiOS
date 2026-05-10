// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "Features",
  platforms: [
    .iOS(.v14),
    .macOS(.v12)
  ],
  products: [
    .library(name: "HomeFeature", targets: ["HomeFeature"]),
    .library(name: "DetailFeature", targets: ["DetailFeature"]),
    .library(name: "FavoriteFeature", targets: ["FavoriteFeature"]),
    .library(name: "SearchFeature", targets: ["SearchFeature"]),
    .library(name: "ProfileFeature", targets: ["ProfileFeature"])
  ],
  dependencies: [
    .package(path: "../CoreCommon")
  ],
  targets: [
    .target(name: "HomeFeature", dependencies: ["CoreCommon"]),
    .target(name: "DetailFeature", dependencies: ["CoreCommon"]),
    .target(name: "FavoriteFeature", dependencies: ["CoreCommon"]),
    .target(name: "SearchFeature", dependencies: ["CoreCommon"]),
    .target(name: "ProfileFeature", dependencies: ["CoreCommon"]),
    .testTarget(name: "HomeFeatureTests", dependencies: ["HomeFeature"]),
    .testTarget(name: "DetailFeatureTests", dependencies: ["DetailFeature"]),
    .testTarget(name: "FavoriteFeatureTests", dependencies: ["FavoriteFeature"]),
    .testTarget(name: "SearchFeatureTests", dependencies: ["SearchFeature"]),
    .testTarget(name: "ProfileFeatureTests", dependencies: ["ProfileFeature"])
  ]
)
