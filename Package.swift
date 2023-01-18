// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "FingerprintJS",
    platforms: [.iOS(.v12), .tvOS(.v12)],
    products: [
        .library(
            name: "FingerprintJS",
            targets: ["FingerprintJS"]
        ),
        .library(
            name: "SystemControl",
            targets: ["SystemControl"]
        ),
    ],
    targets: [
        .target(
            name: "FingerprintJS",
            dependencies: ["SystemControl"]
        ),
        .target(
            name: "SystemControl",
            dependencies: []
        ),
        .testTarget(
            name: "FingerprintJSTests",
            dependencies: ["FingerprintJS"]
        ),
        .testTarget(
            name: "SystemControlTests",
            dependencies: ["SystemControl"]
        ),
    ]
)
