// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "SwiFTC",
    platforms: [
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
        .macOS(.v10_15),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "SwiFTC",
            targets: ["SwiFTC"]
        )
    ],
    targets: [
        .target(
            name: "SwiFTC"
        ),
        .testTarget(
            name: "FTCAPITests",
            dependencies: ["SwiFTC"],
            resources: [
                .copy("FTCAPITestConfig.json")
            ]
        ),
    ]
)
