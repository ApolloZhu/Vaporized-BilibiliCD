// swift-tools-version:4.0
// Managed by ice

import PackageDescription

let package = Package(
    name: "Vaporized-BilibiliCD",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/ApolloZhu/BilibiliKit", from: "1.0.1"),
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "BilibiliKit"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"]),
    ]
)
