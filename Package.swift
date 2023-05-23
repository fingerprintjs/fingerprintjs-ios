// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "FingerprintJS",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
    ],
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
        // Client Libraries
        .target(
            name: "FingerprintJS",
            dependencies: ["SystemControl"]
        ),
        .target(name: "SystemControl"),

        // Tests
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
