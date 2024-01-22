// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "NetworkProvider",
    platforms: [.iOS("15.0")],
    products: [
        .library(
            name: "NetworkProvider",
            targets: ["NetworkProvider"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NetworkProvider",
            dependencies: []),
        .testTarget(
            name: "NetworkProviderTests",
            dependencies: ["NetworkProvider"]),
    ]
)
