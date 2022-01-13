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
      		url: "https://asyschenko.github.io/KMTXBuilds/KMTX-0.3.1.zip",
      		checksum: "cdca1c7a474fde8f8e3140ee026e38a8b6d8cf2f541ab8fe76838d89c6e08f14"
    	)
    ]
)
