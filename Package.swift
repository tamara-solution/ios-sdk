// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "TamaraSDK",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "TamaraSDK",
            targets: ["TamaraSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", from: "14.0.0"),
    ],
    targets: [
        .target(
            name: "TamaraSDK",
            dependencies: ["Moya"],
            path: "TamaraSDK/TamaraSDK"
        ),
        .testTarget(
            name: "TamaraSDKTests",
            dependencies: ["TamaraSDK"],
            path: "TamaraSDK/TamaraSDKTests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
