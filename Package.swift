// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserDefaultsProperty",
    products: [
        .library(
            name: "UserDefaultsProperty",
            targets: ["UserDefaultsProperty"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "UserDefaultsProperty",
            dependencies: []),
        .testTarget(
            name: "UserDefaultsPropertyTests",
            dependencies: ["UserDefaultsProperty"]),
    ]
)
