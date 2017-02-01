//
//  Stream.swift
//  TCP2iMessage
//
//  Created by Damiaan on 1/02/17.
//
//

import Socks
import Foundation

extension TCPClient {
	func whenReceive(data: Data, execute handle: @escaping (Data) -> Void) {
		DispatchQueue.global().async {
			var buffer = Data()
			while !self.socket.closed {
				if let bytes = try? self.receiveAll() {
					buffer.append(bytes, count: bytes.count)
					if let end = buffer.range(of: data) {
						handle(buffer.subdata(in: 0..<end.lowerBound))
						buffer = buffer.subdata(in: end.upperBound..<buffer.endIndex)
					}
				} else { break }
			}
		}
	}
}
