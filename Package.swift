// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FingerprintJS",
    platforms: [.iOS(.v13), .tvOS(.v13)],
    products: [
        .library(
            name: "FingerprintJS",
            targets: ["FingerprintJS"]
        ),
    ],
    targets: [
        .target(name: "FingerprintJS"),
        .testTarget(
            name: "FingerprintJSTests",
            dependencies: ["FingerprintJS"],
            path: "./Sources/FingerprintJSTests"
        )
    ]
)
