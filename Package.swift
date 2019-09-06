// swift-tools-version:5.0
// Managed by ice

import PackageDescription

let package = Package(
    name: "OneSignal",
    products: [
        .library(name: "OneSignal", targets: ["OneSignal"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.0.0-alpha.1"),
    ],
    targets: [
        .target(name: "OneSignal", dependencies: ["AsyncHTTPClient"]),
        .testTarget(name: "OneSignalTests", dependencies: ["OneSignal"]),
    ]
)
