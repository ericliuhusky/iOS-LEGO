// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Dynamic",
    products: [
        .library(
            name: "Dynamic",
            targets: ["Dynamic"])
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "Dynamic",
            dependencies: []),
        .testTarget(
            name: "DynamicTests",
            dependencies: ["Dynamic"]),
    ]
)
