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
    .package(url: "https://github.com/deltarfd/DeltaGamesiOS-CoreCommon.git", from: "1.0.1")
  ],
  targets: [
    .target(name: "HomeFeature", dependencies: [.product(name: "CoreCommon", package: "deltagamesios-corecommon")]),
    .target(name: "DetailFeature", dependencies: [.product(name: "CoreCommon", package: "deltagamesios-corecommon")]),
    .target(name: "FavoriteFeature", dependencies: [.product(name: "CoreCommon", package: "deltagamesios-corecommon")]),
    .target(name: "SearchFeature", dependencies: [.product(name: "CoreCommon", package: "deltagamesios-corecommon")]),
    .target(name: "ProfileFeature", dependencies: [.product(name: "CoreCommon", package: "deltagamesios-corecommon")]),
    .testTarget(name: "HomeFeatureTests", dependencies: ["HomeFeature"]),
    .testTarget(name: "DetailFeatureTests", dependencies: ["DetailFeature"]),
    .testTarget(name: "FavoriteFeatureTests", dependencies: ["FavoriteFeature"]),
    .testTarget(name: "SearchFeatureTests", dependencies: ["SearchFeature"]),
    .testTarget(name: "ProfileFeatureTests", dependencies: ["ProfileFeature"])
  ]
)
