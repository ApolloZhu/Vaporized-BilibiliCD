// swift-tools-version:5.2
// Managed by ice

import PackageDescription

let package = Package(
    name: "Vaporized-BilibiliCD",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(name: "Run", targets: ["Run"]),
        .library(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.48.2"),
        .package(url: "https://github.com/ApolloZhu/BilibiliKit", .branch("rsa")),
        .package(url: "https://github.com/vapor/leaf", from: "4.1.2"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "BilibiliKit", package: "BilibiliKit"),
            .product(name: "Leaf", package: "leaf"),
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"]),
    ]
)
