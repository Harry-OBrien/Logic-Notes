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
	var collections: [Collection]
	var associatedPrograms: [Program]
		
	init(title: String?) {
		if let title = title {
			self.title = title
		}
		else {
			self.title = "Untitled Board"
		}
		
		collections = [Collection]()
		associatedPrograms = [Program]()
	}
	
	static func from(json: String) -> Board {
		let jsonData = json.data(using: .utf8)!
		
		let decoder = JSONDecoder()
		let board = try! decoder.decode(Board.self, from: jsonData)
		
		return board
	}
}

// MARK: Mock board creation
extension Board {
	static var mockBoard1: Board {
		var board = Board(title: "To Do")
		
		// Collection 1
		try! board.addCollection(title: "Tasks", x: -600, y: -300)
		board.collections[0].addNote(content: "Tidy Room")
		board.collections[0].addNote(content: "Food shop")
		board.collections[0].addNote(content: "Party")

		// Collection 2
		try! board.addCollection(title: "Doing", locked: true)
		board.collections[1].addNote(content: "Buy Train Tickets")

		// Collection 3
		try! board.addCollection(title: "Complete", x: -300, y: 300)
		board.collections[2].addNote(content: "Go for a run")
		board.collections[2].addNote(content: "Fix Robot")
		board.collections[2].addNote(content: "Comp Vis Lecture 3")
		
		print("Initialised with mock data")
		return board
	}
	
//	static var mockBoard2: Board {
//		let jsonString = """
//			{"title":"To Do","collections":[{"y":-254,"id":"Today","notes":[{"id":"BF7CD6FF-7321-4D70-BC13-51C211DEE30D","text":"Tidy Room"},{"id":"7F268F4C-7F52-4932-A2C0-C27637B349C5","text":"Food shop"},{"id":"68700059-FFAD-4155-BEAB-CD523983008C","text":"Lecture 1"}],"locked":true,"x":-445},{"y":-257,"id":"Doing","notes":[{"id":"F7CF73ED-2C07-4360-84D2-E2016E4483AD","text":"Add feature to Logic Notes app"}],"locked":true,"x":29},{"y":-255,"id":"Complete","notes":[{"id":"85D3D2B6-4E12-4C31-BFCF-A8F51E602D95","text":"Go for a run"},{"id":"BFBE71F5-5B4F-4D4C-B809-27E2A0C42937","text":"Fix Bugs"},{"id":"58AC37CC-2DF2-4DA9-BD96-CD1A91EDDE9C","text":"Algorithms Lecture 3"}],"locked":true,"x":484},{"y":215,"id":"Unallocated Tasks","notes":[{"id":"8C7569B1-7E59-4B86-985A-782B452A90D1","text":"Party"},{"id":"8C7569F1-7E59-4B86-985A-782B452A90D1","text":"Lecture 5"},{"id":"8C7569F1-7E59-4B96-985A-782B452A90D1","text":"Lecture 6"},{"id":"8C7569F1-7E59-4B96-986A-782B452A90D1","text":"Do boring tax stuff"}],"locked":true,"x":-890},{"y":299,"id":"+2","notes":[{"id":"D3A6AE2B-5177-49C2-9275-D7191E4F1A52","text":"Take dog for a walk"},{"id":"D3A6AE2B-5177-49C3-9275-D7191E4F1A52","text":"ML worksheet 3"}],"locked":true,"x":-334},{"y":591,"id":"+3","notes":[{"id":"62CB8CF7-23AD-4D38-9D90-0747CAA0298E","text":"Revise deep learning models"}],"locked":true,"x":-336},{"y":18,"id":"+1","notes":[{"id":"BB70A6E1-2F73-4026-BCA7-6797DBF1744D","text":"Computer Vision exam"}],"locked":true,"x":-328}],"uniqueCollectionId":8}
//		"""
//
//		print("Initialised with mock data")
//		return Board.from(json: jsonString)
//	}
}
