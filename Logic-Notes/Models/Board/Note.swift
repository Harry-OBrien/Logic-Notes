//
//  Note.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 14/09/2021.
//

import Foundation


extension Board.Collection {
	// TODO: Implement CustomStringConvertible protocol
	/// A note within a collection on a board
	struct Note: Identifiable, Codable {
		let id: UUID
		var text: String
		
		fileprivate init(text: String) {
			self.id = UUID()
			self.text = text
		}
	}
	
	mutating func addNote(content: String) {
		notes.append(Note(text: content))
	}
}
