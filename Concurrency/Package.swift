// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Concurrency",
    products: [
        .executable(
            name: "Concurrency",
            targets: ["Concurrency"]),
    ],
    dependencies: [

    ],
    targets: [
        .executableTarget(
            name: "Concurrency",
            swiftSettings: [
                .unsafeFlags(["-Xfrontend", "-enable-experimental-concurrency"])
            ]),
    ]
)
