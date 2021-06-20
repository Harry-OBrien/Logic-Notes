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
	var collections = [Collection]()
		
	init(title: String?) {
		if let title = title {
			self.title = title
		}
		else {
			self.title = "Untitled Board"
		}
	}
	
	static func from(json: String) -> Board {
		let jsonData = json.data(using: .utf8)!
		
		let decoder = JSONDecoder()
		let board = try! decoder.decode(Board.self, from: jsonData)
		
		print("Initialised with mock data")
		
		return board
	}
	
	
	struct Collection: Identifiable, Codable {
		
		let id: Int
		var title: String
		var notes: [Note]
		var locked: Bool
		var x: Int
		var y: Int
		
		class Note: NSObject, Identifiable, Codable, NSItemProviderWriting, NSItemProviderReading {
			let id: UUID
			var text: String
			
			fileprivate init(text: String) {
				self.id = UUID()
				self.text = text
			}
			
			static var writableTypeIdentifiersForItemProvider: [String] { [(kUTTypeData as String)]}
			
			func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
				let progress = Progress(totalUnitCount: 100)
				
				do {
					let data = try JSONEncoder().encode(self)
					progress.completedUnitCount = 100
					completionHandler(data, nil)
					
				} catch {
					completionHandler(nil, error)
				}
				
				return progress
			}
			
			static var readableTypeIdentifiersForItemProvider: [String] { [(kUTTypeData as String)] }
			
			static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
				let decoder = JSONDecoder()
				
				do {
					let subject = try decoder.decode(Note.self, from: data)
					return subject as! Self
				} catch {
					fatalError(error.localizedDescription)
				}
			}
		}
		
		fileprivate init(id: Int, title: String, notes: [Note], locked: Bool, x: Int, y: Int) {
			self.id = id
			self.title = title
			self.notes = notes
			self.locked = locked
			self.x = x
			self.y = y
		}
		
		// Create a new note
		mutating func addNote(_ text: String) {
			notes.append(Note(text: text))
		}
		
		mutating func addNote(_ oldNote: Note) {
			notes.append(Note(text: oldNote.text))
		}
		
		mutating func removeNote(_ note: Note) {
			notes = notes.filter { $0.id != note.id }
		}
	}
	
	// Create collection containing a single note
	@discardableResult
	mutating func addCollection(title: String?, locked: Bool = false, x: Int = 0, y: Int = 0) -> Int {
		var newCollectionTitle: String!
		if title == nil {
			newCollectionTitle = "Group \(uniqueCollectionId)"
		} else {
			newCollectionTitle = title!
		}
		
		let newCollection = Collection(id: uniqueCollectionId,
									   title: newCollectionTitle,
									   notes: [],
									   locked: locked,
									   x: x,
									   y: y)
		collections.append(newCollection)
		uniqueCollectionId += 1
		
		return collections.endIndex - 1
	}
	
	private var uniqueCollectionId = 0
	
	var json: Data? {
		return try? JSONEncoder().encode(self)
	}
}

// MARK: - Mock board creation
extension Board {
	static func getMockBoard1() -> Board {
		var board = Board(title: "To Do")
		
		// Collection 1
		board.addCollection(title: "Tasks", x: -600, y: -300)
		board.collections[0].addNote("Tidy Room")
		board.collections[0].addNote("Food shop")
		board.collections[0].addNote("Party")
		
		// Collection 2
		board.addCollection(title: "Doing", locked: true)
		board.collections[1].addNote("Buy Train Tickets")
		
		// Collection 3
		board.addCollection(title: "Complete", x: -300, y: 300)
		board.collections[2].addNote("Go for a run")
		board.collections[2].addNote("Fix Robot")
		board.collections[2].addNote("Comp Vis Lecture 3")
		
		print("Initialised with mock data")
		
		return board
	}
	
	static func getMockBoard2() -> Board {
		let jsonString = """
			{"title":"To Do","collections":[{"y":-254,"id":0,"title":"Today","notes":[{"id":"BF7CD6FF-7321-4D70-BC13-51C211DEE30D","text":"Tidy Room"},{"id":"7F268F4C-7F52-4932-A2C0-C27637B349C5","text":"Food shop"},{"id":"68700059-FFAD-4155-BEAB-CD523983008C","text":"Lecture 1"}],"locked":true,"x":-445},{"y":-257,"id":1,"title":"Doing","notes":[{"id":"F7CF73ED-2C07-4360-84D2-E2016E4483AD","text":"Add feature to Logic Notes app"}],"locked":true,"x":29},{"y":-255,"id":2,"title":"Complete","notes":[{"id":"85D3D2B6-4E12-4C31-BFCF-A8F51E602D95","text":"Go for a run"},{"id":"BFBE71F5-5B4F-4D4C-B809-27E2A0C42937","text":"Fix Bugs"},{"id":"58AC37CC-2DF2-4DA9-BD96-CD1A91EDDE9C","text":"Algorithms Lecture 3"}],"locked":true,"x":484},{"y":215,"id":3,"title":"Unallocated Tasks","notes":[{"id":"8C7569B1-7E59-4B86-985A-782B452A90D1","text":"Party"},{"id":"8C7569F1-7E59-4B86-985A-782B452A90D1","text":"Lecture 5"},{"id":"8C7569F1-7E59-4B96-985A-782B452A90D1","text":"Lecture 6"},{"id":"8C7569F1-7E59-4B96-986A-782B452A90D1","text":"Do boring tax stuff"}],"locked":true,"x":-890},{"y":299,"id":4,"title":"+2","notes":[{"id":"D3A6AE2B-5177-49C2-9275-D7191E4F1A52","text":"Take dog for a walk"},{"id":"D3A6AE2B-5177-49C3-9275-D7191E4F1A52","text":"ML worksheet 3"}],"locked":true,"x":-334},{"y":591,"id":5,"title":"+3","notes":[{"id":"62CB8CF7-23AD-4D38-9D90-0747CAA0298E","text":"Revise deep learning models"}],"locked":true,"x":-336},{"y":18,"id":6,"title":"+1","notes":[{"id":"BB70A6E1-2F73-4026-BCA7-6797DBF1744D","text":"Computer Vision exam"}],"locked":true,"x":-328}],"uniqueCollectionId":8}
			"""
		
		return Board.from(json: jsonString)
	}
}
