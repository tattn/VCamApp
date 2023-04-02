// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "VCam",
    defaultLocalization: "en",
    platforms: [.macOS(.v12)],
    products: [
        .library(name: "VCam", targets: ["VCamUI", "VCamMedia", "VCamBridge"]),
        .library(name: "VCamMedia", targets: ["VCamMedia"]),
        .library(name: "VCamCamera", targets: ["VCamCamera"]),

        .library(name: "VCamDefaults", targets: ["VCamDefaults"]),
        .library(name: "VCamAppExtension", targets: ["VCamAppExtension"]),
    ],
    dependencies: [
        .package(url: "https://github.com/siteline/SwiftUI-Introspect", exact: "0.2.0"),
    ],
    targets: [
        .target(name: "VCamUI", dependencies: [
            "VCamUIFoundation", "VCamTracking", "VCamCamera", "VCamData", "VCamLocalization", "VCamBridge",
            .product(name: "Introspect", package: "SwiftUI-Introspect")
        ]),
        .target(name: "VCamUIFoundation"),
        .target(name: "VCamData", dependencies: ["VCamEntity"]),
        .target(name: "VCamEntity", dependencies: ["VCamDefaults", "VCamLocalization"], swiftSettings: [
//            .define("ENABLE_MOCOPI")
        ]),
        .target(name: "VCamLocalization", resources: [.process("VCamResources")]),
        .target(name: "VCamMedia", dependencies: ["VCamEntity", "VCamAppExtension"]),
        .target(name: "VCamBridge", dependencies: ["VCamUIFoundation"]),
        .target(name: "VCamCamera", dependencies: ["VCamEntity"]),
        .target(name: "VCamTracking", dependencies: ["VCamLogger"]),

        .target(name: "VCamLogger", dependencies: []),
        .target(name: "VCamDefaults", dependencies: []),
        .target(name: "VCamAppExtension", dependencies: []),

        .testTarget(name: "VCamTrackingTests", dependencies: ["VCamTracking"]),
        .testTarget(name: "VCamAppExtensionTests", dependencies: ["VCamAppExtension"]),
    ]
)
