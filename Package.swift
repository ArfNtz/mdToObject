// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mdToObject",
    products: [
        .library(name: "mdToObject", targets: ["mdToObject"]),
        .executable(name: "flyerExample", targets: ["flyerExample"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ArfNtz/lex.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "mdToObject",
            dependencies: ["lex"]),
        .testTarget(
            name: "mdToObjectTests",
            dependencies: ["mdToObject"]),
        .target(
            name: "flyerExample",
            dependencies: ["mdToObject"]),
    ]
)
