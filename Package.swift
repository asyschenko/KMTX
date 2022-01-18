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
      		url: "https://asyschenko.github.io/KMTXBuilds/KMTX-0.3.2.zip",
      		checksum: "a49be147c1189bc35ae8bf12bf4a08faed0c9af44cab94b4f5507992083d0dc5"
    	)
    ]
)
