import PackageDescription

let package = Package(
	name: "Rapid",
	dependencies: [
		.Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 0),
		.Package(url: "https://github.com/IBM-Swift/Kitura-net.git", majorVersion: 1, minor: 0)
	])
