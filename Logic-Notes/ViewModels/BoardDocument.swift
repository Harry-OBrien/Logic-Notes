//
//  BoardViewModel.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import SwiftUI

class BoardDocument: ObservableObject {
	
	// TODO: Implement better setters and getters for collections so we don't have to do 'let index = ...; board.collections[index].notes = ...'
	
	@Published private var board: Board {
		didSet {
			//			print("JSON: \(board.json?.utf8 ?? "Empty")")
		}
	}
	
	var boardTitle: String { board.title }
	var collections: [Board.Collection] { board.collections }
	var associatedPrograms: [Program] { board.associatedPrograms }
	
	@Published var steadyStateZoomScale: CGFloat = 1.0
	@Published var steadyStatePanOffset: CGSize = .zero
	
	init(board: Board) {
		self.board = board
		recenterCollections()
	}
	
	// MARK: Board geometry
	var boundingBox: CGRect {
		var left = Int.max
		var right = -Int.max
		var top = Int.max
		var bottom = -Int.max
		
		for collection in collections {
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
		for (i, _) in collections.enumerated() {
			board.collections[i].x -= Int(currentBounds.midX)
			board.collections[i].y -= Int(currentBounds.midY)
		}
	}
	
	func collectionIndexForNote(_ note: Board.Collection.Note) -> Int? {
		for (index, collection) in collections.enumerated() {
			if collection.firstIndexContaining(note: note) != nil {
				return index
			}
		}
		
		return nil
	}
	
	// MARK: - Collection Intent(s)
	// Create, (Read), Update, Delete
	/// Create
	func createCollection(titled title: String?, at location: CGPoint) throws {
		try board.addCollection(title: title, locked: false, x: Int(location.x), y: Int(location.y))
	}
	
	// TODO: Redesign update functions to be cleaner
	/// update
	func moveCollection(_ collection: Board.Collection, by offset: CGSize) {
		if let index = board.collections.firstIndex(matching: collection) {
			board.collections[index].x += Int(offset.width)
			board.collections[index].y += Int(offset.height)
		}
	}
	
	/// Update
	func renameCollection(_ oldCollection: Board.Collection, to newTitle: String) throws {
		// Try and create a new collection
		try board.addCollection(title: newTitle, x: oldCollection.x, y: oldCollection.y)
		
		// Now delete the old collection
		deleteCollection(oldCollection)
	}
	
	/// update
	func toggleCollectionLocked(_ collection: Board.Collection) {
		if let index = board.collections.firstIndex(matching: collection) {
			board.collections[index].locked.toggle()
			
			// TODO: Warn user of deletion
			//			if board.collections[index].notes.count <= 0 && !board.collections[index].locked {
			//				removeCollection(collection)
			//			}
		}
	}
	
	/// delete
	func deleteCollection(_ collection: Board.Collection) {
		board.collections = board.collections.filter { $0.id != collection.id }
	}
	
	// MARK: - Note Intent(s)
	// Create (Read) Update Delete
	
	/// create
	func createNote(withContents content: String, at location: CGPoint = .zero) {
		let newCollectionID = try! board.addCollection(title: nil, x: Int(location.x), y: Int(location.y))
		let collectionIndex = board.collections.firstIndex(where: { $0.id == newCollectionID })!
		
		board.collections[collectionIndex].addNote(content: content)
	}
	
	// TODO: Re-implement
	/// update
//	func moveNote(_ note: Board.Collection.Note, to collection: Board.Collection) {
//		if let index = board.collections.firstIndex(matching: collection) {
//			DispatchQueue.main.async {
//				self.board.collections[index].addNote(note)
//			}
//		}
//
//		removeNote(note)
//	}
	
	/// delete
//	func deleteNote(_ note: Board.Collection.Note) {
//		if let index = collectionIndexForNote(note) {
//			DispatchQueue.main.async {
//				self.board.collections[index].removeNote(note)
//				if self.board.collections[index].notes.count <= 0 && !self.board.collections[index].locked {
//					self.removeCollection(self.board.collections[index])
//				}
//			}
//
//		}
//	}
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
