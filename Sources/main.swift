import Foundation
import Socks

let separator = "--next-image--".data(using: .utf8)!
let tmpFolder = FileManager.default.temporaryDirectory.appendingPathComponent("com.devian.imageSender")
var counter = UInt8(0)

print("Saving temporary files as 'image-counter.jpg' in:", tmpFolder)

do {
	try FileManager.default.createDirectory(at: tmpFolder, withIntermediateDirectories: true)
	let server = try SynchronousTCPServer(port: 8765)
	try server.startWithHandler { client in
		client.whenReceive(data: separator) { receivedData in
			let url = tmpFolder.appendingPathComponent("image-\(counter).jpeg")
			try? receivedData.write(to: url)
			Process.launchedProcess(launchPath: "/usr/bin/osascript", arguments: ["-e", "tell application \"Messages\" to send POSIX file \"\(url.path)\" to buddy \"damiaan@me.com\" of service \"E:micheldufaux@mac.com\""])
			counter = (counter+1) % UInt8.max
		}
	}
}
	
catch { print("Error: \(error)") }
