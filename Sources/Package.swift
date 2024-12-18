// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Benchmark_app",
    products: [
        .library(
            name: "Benchmark_app",
            targets: ["Benchmark_app"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/tmthecoder/Argon2Swift.git", .branch("main"))
    ],
    targets: [
        .target(
            name: "Benchmark_app",
            dependencies: []
        ),
        .testTarget(
            name: "Benchmark_appTests",
            dependencies: [
                "Benchmark_app",
                "Argon2Swift"
            ]
        ),
    ]
)
