// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BibleUI",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .visionOS(.v1),
        .watchOS(.v10),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "BibleUI",
            targets: ["BibleUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SwordReader/BibleKit.git", exact: "0.3.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "BibleUI",
            dependencies: [
                .product(name: "BibleKit", package: "BibleKit"),
            ]
        ),
        .testTarget(
            name: "BibleUITests",
            dependencies: [
                "BibleUI",
                .product(name: "BibleKit", package: "BibleKit"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
