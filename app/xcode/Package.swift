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
    ],
    dependencies: [
        .package(url: "https://github.com/siteline/SwiftUI-Introspect", exact: "0.1.4"),
    ],
    targets: [
        .target(name: "VCamUI", dependencies: [
            "VCamUIFoundation", "VCamCamera", "VCamData", "VCamLocalization", "VCamBridge",
            .product(name: "Introspect", package: "SwiftUI-Introspect")
        ]),
        .target(name: "VCamUIFoundation"),
        .target(name: "VCamData", dependencies: ["VCamEntity"]),
        .target(name: "VCamEntity"),
        .target(name: "VCamLocalization", resources: [.process("VCamResources")]),
        .target(name: "VCamMedia", dependencies: ["VCamEntity"]),
        .target(name: "VCamBridge", dependencies: ["VCamUIFoundation"]),
        .target(name: "VCamCamera", dependencies: ["VCamEntity"]),
    ]
)
