// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "CoreCommon",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v14),
    .macOS(.v12)
  ],
  products: [
    .library(
      name: "CoreCommon",
      targets: ["CoreCommon"]
    )
  ],
  targets: [
    .target(
      name: "CoreCommon",
      resources: [
        .process("Resources")
      ]
    ),
    .testTarget(
      name: "CoreCommonTests",
      dependencies: ["CoreCommon"]
    )
  ]
)
