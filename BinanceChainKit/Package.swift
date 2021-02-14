// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let dependencies3rd: [Target.Dependency] = ["Alamofire",
                                            "ObjectMapper",
                                            "RxSwift",
                                            "SwiftyJSON",
                                            "SwiftProtobuf",
                                            "GRDB"]

let package = Package(
    name: "BinanceChainKit",
    platforms: [.macOS(.v10_13),
                .iOS(.v11)],
    products: [
        .library(
            name: "BinanceChainKit",
            targets: ["BinanceChainKit"]
        ),
    ],
    dependencies: [
        .package(name: "secp256k1", url: "https://github.com/Boilertalk/secp256k1.swift.git", from: "0.1.0"),
        .package(name: "SwiftProtobuf", url: "https://github.com/apple/swift-protobuf.git", from: "1.15.0"),
        .package(name: "SwiftyJSON", url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.3.0"),
        .package(name: "RxSwift", url: "https://github.com/ReactiveX/RxSwift.git", from: "5.1.1"),
        .package(name: "ObjectMapper", url: "https://github.com/tristanhimmelman/ObjectMapper.git", from: "3.5.3"),
        .package(name: "Alamofire", url: "https://github.com/Alamofire/Alamofire.git", from: "5.2.2"),
        .package(name: "GRDB", url: "https://github.com/groue/GRDB.swift.git", from: "5.3.0"),
    ],
    targets: [
        .binaryTarget(name: "OpensslFramework",
                      path: "Sources/OpensslFramework/openssl.xcframework"),
        .target(
            name: "CryptoKitPrivate",
            dependencies: ["OpensslFramework"],
            path: "Sources/CryptoKitPrivate"
        ),
        .target(
            name: "OpenSslKit",
            dependencies: dependencies3rd + ["CryptoKitPrivate"],
            path: "Sources/OpenSslKit"
        ),
        .target(
            name: "Secp256k1Kit",
            dependencies: dependencies3rd + ["OpenSslKit", "secp256k1"],
            path: "Sources/Secp256k1Kit"
        ),
        .target(
            name: "HdWalletKit",
            dependencies: dependencies3rd + ["OpenSslKit", "Secp256k1Kit"],
            path: "Sources/HdWalletKit"
        ),
        .target(
            name: "HsToolKit",
            dependencies: dependencies3rd + ["OpenSslKit", "Secp256k1Kit"],
            path: "Sources/HsToolKit"
        ),

        .target(
            name: "BinanceChainKit",
            dependencies: dependencies3rd + ["OpenSslKit", "HdWalletKit", "HsToolKit"],
            path: "Sources/BinanceChainKit"
        ),
        .testTarget(
            name: "BinanceChainKitTests",
            dependencies: ["BinanceChainKit"]
        ),
    ]
)
