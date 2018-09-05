// swift-tools-version:4.0
// Managed by ice

import PackageDescription

let package = Package(
    name: "OneSignal",
    products: [
        .library(name: "OneSignal", targets: ["OneSignal"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0")
    ],
    targets: [
        .target(name: "OneSignal", dependencies: ["Vapor"]),
        .testTarget(name: "OneSignalTests", dependencies: ["OneSignal"]),
    ]
)
