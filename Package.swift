// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "SwiFTC",
    platforms: [
        .iOS(.v16),
        .watchOS(.v9),
        .tvOS(.v16),
        .macOS(.v13),
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
            name: "SwiFTC",
            resources: [
                .copy("Timer/Audio/countdown.wav"),
                .copy("Timer/Audio/end.wav"),
                .copy("Timer/Audio/endgame.wav"),
                .copy("Timer/Audio/pickup.wav"),
                .copy("Timer/Audio/start.wav"),
                .copy("Timer/Audio/teleop.wav"),
                .copy("Timer/Audio/transition.wav"),
            ]
        ),
        .target(
            name: "SwiFTCTestErrors"
        ),
        .testTarget(
            name: "FTCAPIV2Tests",
            dependencies: ["SwiFTC"],
            resources: [
                .copy("FTCAPIV2TestConfig.json")
            ]
        ),
        .testTarget(
            name: "LibIntoTheDeepTests",
            dependencies: ["SwiFTC", "SwiFTCTestErrors"],
            resources: [
                .copy("LibIntoTheDeepTestData.json")
            ]
        ),
        .testTarget(
            name: "LibDecodeTests",
            dependencies: ["SwiFTC", "SwiFTCTestErrors"],
            resources: [
                .copy("LibDecodeTestData.json")
            ]
        ),
        .testTarget(
            name: "GameTimerTests",
            dependencies: ["SwiFTC"]
        ),
    ]
)
