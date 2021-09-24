//
//  Collection.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation
import MobileCoreServices

struct Board: Codable {
	var title: String
	var collections: [CollectionID: Collection]
	var associatedPrograms: [Program]
		
	init(title: String? = nil) {
		self.title = title ?? "Untitled Board"
		
		collections = [:]
		associatedPrograms = []
	}
	
	static func from(json: String) -> Board {
		let jsonData = json.data(using: .utf8)!
		
		let decoder = JSONDecoder()
		let board = try! decoder.decode(Board.self, from: jsonData)
		
		return board
	}
	
	var json: Data? {
		return try? JSONEncoder().encode(self)
	}
}

// MARK: Mock board creation
extension Board {
	static var mockBoard: Board {
		let url = Bundle.main.url(forResource: "BoardJSON", withExtension: ".json")!
		let mockJSONData = try! Data(contentsOf: url)
		let board = try! JSONDecoder().decode(Board.self, from: mockJSONData)
		
		print("Initialised with mock data")
		
		return board
	}
}
