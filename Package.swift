// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "KMTX",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "KMTX",
            targets: ["KMTX"]),
    ],
    targets: [
    	.binaryTarget(
    		name: "KMTX",
      		url: "https://asyschenko.github.io/KMTXBuilds/KMTX-0.3.0.zip",
      		checksum: "73153839abb073a6d71ef7f1434efdf24c3275b20adfc7179204c056ed7290b3"
    	)
    ]
)
