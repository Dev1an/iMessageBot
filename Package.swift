import PackageDescription

let package = Package(
    name: "TCP2iMessage",
    dependencies: [
		.Package(url: "https://github.com/vapor/socks.git", majorVersion: 1)
	]
)
