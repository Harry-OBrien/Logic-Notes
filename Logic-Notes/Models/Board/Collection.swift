//
//  Collection.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 14/09/2021.
//

import Foundation

typealias CollectionID = String

extension Board {
	/// A collection on a board
	struct Collection: Identifiable, Codable {
		
		let id: CollectionID
		var notes: [Note]
		var locked: Bool
		var x: Int
		var y: Int
		
		enum CreationError: Error {
			case notUnique
		}
	}
	
	// MARK: Collection creation
	// Create collection
	mutating func createCollection(id: CollectionID? = nil, locked: Bool = false, x: Int = 0, y: Int = 0) throws {
		var namedID: CollectionID!
		
		// If we have been passed a title for the new collection
		if let id = id {
			// Ensure ID is unique in collections
			if collectionExists(id: id) {
				throw Collection.CreationError.notUnique
			}
			
			namedID = id
		} else {
			// Find the first collection title that is unique
			// TODO: Come back to this and find a more elegant solution
			var offset = 0
			while true {
				namedID = "Collection \(collections.count + 1 + offset)"
				// try another number if this collection already exists
				if !collectionExists(id: namedID) {
					break
				}
				
				offset += 1
			}
		}
		
		// Create the new collection
		let newCollection = Collection(id: namedID,
									   notes: [],
									   locked: locked,
									   x: x,
									   y: y)
		
		// Add to the boards array of collections
		collections[newCollection.id] = newCollection
	}
	
	// Check if collection exists
	func collectionExists(id: String) -> Bool {

		return collections[id] != nil
	}
}
