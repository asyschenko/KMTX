// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KMTX",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "KMTX",
            targets: ["KMTX"]),
    ],
    targets: [
        .binaryTarget(
            name: "KMTX",
            path: "KMTX.xcframework")
    ]
)
