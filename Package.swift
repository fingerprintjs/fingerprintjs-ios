// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "FingerprintJS",
    platforms: [.iOS(.v12), .tvOS(.v12)],
    products: [
        .library(
            name: "FingerprintJS",
            targets: ["FingerprintJS"]
        )
    ],
    targets: [
        .target(name: "FingerprintJS"),
        .testTarget(
            name: "FingerprintJSTests",
            dependencies: ["FingerprintJS"],
            path: "./Sources/FingerprintJSTests"
        ),
    ]
)
