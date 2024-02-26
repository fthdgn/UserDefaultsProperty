// swift-tools-version:5.9

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "UserDefaultsProperty",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "UserDefaultsProperty",
            targets: ["UserDefaultsProperty"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", exact: "509.0.2"),
    ],
    targets: [
        .target(
            name: "UserDefaultsProperty",
            dependencies: [
                "UserDefaultsPropertyMacros"
            ]
        ),
        .macro(
            name: "UserDefaultsPropertyMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
    ]
)
