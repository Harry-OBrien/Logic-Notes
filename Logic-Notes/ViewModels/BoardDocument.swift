//
//  BoardViewModel.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation
import SwiftUI

class BoardDocument: ObservableObject {
	
	@Published private var board: Board {
		didSet {
//			print("JSON: \(board.json?.utf8 ?? "Empty")")
		}
	}
	var collections: [Board.Collection] { board.collections }
	
	@Published var steadyStateZoomScale: CGFloat = 1.0
	@Published var steadyStatePanOffset: CGSize = .zero
	
	init(board: Board) {
		self.board = board
		recenterCollections()
	}
	
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
	@discardableResult
	func addCollection(titled title: String?, at location: CGPoint) -> Int {
		return board.addCollection(title: title, locked: false, x: Int(location.x), y: Int(location.y))
	}
	
	func moveCollection(_ collection: Board.Collection, by offset: CGSize) {
		if let index = board.collections.firstIndex(matching: collection) {
			board.collections[index].x += Int(offset.width)
			board.collections[index].y += Int(offset.height)
		}
	}
	
	func renameCollection(_ collection: Board.Collection, to newTitle: String) {
		if let index = board.collections.firstIndex(matching: collection) {
			board.collections[index].title = newTitle
		}
	}
	
	func removeCollection(_ collection: Board.Collection) {
		board.collections = board.collections.filter { $0.id != collection.id }
	}
	
	func toggleCollectionLocked(_ collection: Board.Collection) {
		if let index = board.collections.firstIndex(matching: collection) {
			board.collections[index].locked.toggle()
			
			// TODO: Warn user of deletion
//			if board.collections[index].notes.count <= 0 && !board.collections[index].locked {
//				removeCollection(collection)
//			}
		}
	}
	
	// MARK: - Note Intent(s)
	func addNote(_ note: String, at location: CGPoint = CGPoint(x: 30, y: 30)) {
		let index = addCollection(titled: nil, at: location)
		board.collections[index].addNote(note)
	}
	
	func addNote(_ note: Board.Collection.Note, at location: CGPoint = CGPoint(x: 30, y: 30)) {
		let index = addCollection(titled: nil, at: location)
		moveNote(note, to: board.collections[index])
	}
	
	func moveNote(_ note: Board.Collection.Note, to collection: Board.Collection) {
		if let index = board.collections.firstIndex(matching: collection) {
			DispatchQueue.main.async {
				self.board.collections[index].addNote(note)
			}
		}
		
		removeNote(note)
	}
	
	func removeNote(_ note: Board.Collection.Note) {
		if let index = collectionIndexForNote(note) {
			DispatchQueue.main.async {
				self.board.collections[index].removeNote(note)
				if self.board.collections[index].notes.count <= 0 && !self.board.collections[index].locked {
					self.removeCollection(self.board.collections[index])
				}
			}
			
		}
	}
	
	func removeNote(_ note: Board.Collection.Note, from collection: Board.Collection) {
		if let index = board.collections.firstIndex(matching: collection) {
			board.collections[index].removeNote(note)
		}
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
