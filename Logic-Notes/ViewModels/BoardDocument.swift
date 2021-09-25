//
//  BoardViewModel.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import SwiftUI

// TODO: Refactor intents (to make them actual intents and not just CRUD)
class BoardDocument: ObservableObject {
		
	@Published private var board: Board {
		didSet {
			//			print("JSON: \(board.json?.utf8 ?? "Empty")")
		}
	}
	
	var boardTitle: String { board.title }
	
	@Published var steadyStateZoomScale: CGFloat = 1.0
	@Published var steadyStatePanOffset: CGSize = .zero
	
	init(board: Board) {
		self.board = board
		recenterCollections()
	}
	
	// MARK: Board geometry
	var boundingBox: CGRect {
		if collections.isEmpty {
			return .zero
		}
		
		var left = Int.max
		var right = -Int.max
		var top = Int.max
		var bottom = -Int.max
		
		for (_, collection) in collections {
			if collection.x < left {
				left = collection.x
			}
			if collection.x > right {
				right = collection.x
			}
			if collection.y < top {
				top = collection.y
			}
			if collection.y > bottom {
				bottom = collection.y
			}
		}
		
		return CGRect(x: left, y: top, width: right - left, height: bottom - top)
	}
	
	func recenterCollections() {
		// Get current bounding box
		let currentBounds = boundingBox
		
		// average out locations
		for (collectionKey, _) in collections {
			board.collections[collectionKey]!.x -= Int(currentBounds.midX)
			board.collections[collectionKey]!.y -= Int(currentBounds.midY)
		}
	}
	
	// MARK:  Collection Intent(s)
	// Create, Read, Update, Delete
	/// Create
	func createCollection(titled title: String? = nil, at location: CGPoint = .zero) throws {
		try board.createCollection(id: title, locked: false, x: Int(location.x), y: Int(location.y))
	}
	
	/// Read by ID
	func getCollection(titled collectionID: CollectionID) -> Board.Collection? {
		return collections[collectionID]
	}
	
	/// Read all
	var collections: [CollectionID: Board.Collection] { board.collections }
	
	var collectionIDs: [String] { Array(collections.keys) }
	
	/// update
	func moveCollection(_ collection: Board.Collection, by offset: CGSize) {
		board.collections[collection.id]?.x += Int(offset.width)
		board.collections[collection.id]?.y += Int(offset.height)
	}
	
	func moveCollection(_ collection: Board.Collection, to point: CGPoint) {
		board.collections[collection.id]?.x = Int(point.x)
		board.collections[collection.id]?.y = Int(point.y)
	}
	
	/// Update
	func renameCollection(_ old: Board.Collection, to newTitle: String) throws {
		// We don't need to do anything if we're changing to the same name
		if old.id == newTitle {
			return
		}
		
		try board.createCollection(id: newTitle, locked: old.locked, x: old.x, y: old.y)
		deleteCollection(old)
	}
	
	/// update
	func toggleCollectionLocked(_ collection: Board.Collection) {
		board.collections[collection.id]?.locked.toggle()
	}
	
	/// delete
	func deleteCollection(_ collection: Board.Collection) {
		board.collections.removeValue(forKey: collection.id)
	}
	
	// MARK: Note Intent(s)
	// Create (Read) Update Delete
	
	/// create
	func createNote(withContents content: String, at location: CGPoint = .zero) {
		//	let newCollectionID = try! board.createCollection(id: nil, x: Int(location.x), y: Int(location.y))
		//	let collectionIndex = board.collections.firstIndex(where: { $0.id == newCollectionID })!
		//
		//	board.collections[collectionIndex].addNote(content: content)
	}
	
	// TODO: Re-implement
	/// update
	func moveNote(_ note: Board.Collection.Note, to collection: Board.Collection) {
		//		if let index = board.collections.firstIndex(matching: collection) {
		//			DispatchQueue.main.async {
		//				self.board.collections[index].addNote(note)
		//			}
		//		}
		//
		//		removeNote(note)
	}
	
	/// delete
	func deleteNote(_ note: Board.Collection.Note) {
		//		if let index = collectionIndexForNote(note) {
		//			DispatchQueue.main.async {
		//				self.board.collections[index].removeNote(note)
		//				if self.board.collections[index].notes.count <= 0 && !self.board.collections[index].locked {
		//					self.removeCollection(self.board.collections[index])
		//				}
		//			}
		//
		//		}
	}
}

extension Board.Collection {
	var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
	
	func firstIndexContaining(note noteToFind: Board.Collection.Note) -> Int? {
		for (index, note) in self.notes.enumerated() {
			if noteToFind.id == note.id {
				return index
			}
		}
		return nil
	}
}

// MARK: - Board Logic
// Everything related to the logic/programming on the board
extension BoardDocument {
	// MARK: Program intentions
	// Create program
	
	// Read single program
	
	// Read programs
	var programs: [Program] { board.associatedPrograms }
	
	// Update program
	
	// Delete program
	
	// MARK: Logic Block Intentions
	// Create
	
	// Get single
	
	// Read all
	
	// Update block
	func update(logicBlock newBlock: LogicBlock, in program: Program) {
		if let programIndex = programs.firstIndex(matching: program),
		   let blockIdx = programs[programIndex].code.firstIndex(where: { $0.id == newBlock.id }){
			board.associatedPrograms[programIndex].code[blockIdx] = newBlock
		}
	}
	
	// MARK: - Program Triggers
	func execute(trigger: Program.Trigger) {
		switch trigger {
			case .flagPressed:
				flagPressed()
				
			default:
				break
		}
	}
	
	private func flagPressed() {
		print("Flag pressed!")
		
		// For every program
		for program in programs {
			// If program is activated by the flag press
			if case .flagPressed = program.trigger {
				// Execute all of the code blocks in order
				for codeBlock in program.code {
					codeBlock.execute()
				}
			}
		}
	}
}
