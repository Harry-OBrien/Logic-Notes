//
//  Collection.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation

struct Collection: Identifiable, Equatable {
	static func == (lhs: Collection, rhs: Collection) -> Bool {
		lhs.id == rhs.id
	}
	
	let id: UUID
	var title: String
	var notes: [Note]
	var locked: Bool
	var offset: (Double, Double)
	
	init(title: String,
		 notes: [Note],
		 locked: Bool = false,
		 offset: (Double, Double) = (0.0, 0.0))
	{
		self.id = UUID()
		self.title = title
		self.notes = notes
		self.locked = locked
		self.offset = offset
	}
}

extension Collection{
	static func getMockCollections() -> [Collection] {
		
		let collections: [Collection] = [
			.init(title: "To Do",
				  notes: [
					.init(content: "Tidy room"),
					.init(content: "Shopping"),
					.init(content: "Machine Learning Lecture 3"),
				  ],
				  offset: (410, 568-300)),
			.init(title: "Doing",
				  notes: [
					.init(content: "Buy train tickets"),
				  ],
				  locked: true,
				  offset: (410, 568)),
			.init(title: "Complete",
				  notes: [
					.init(content: "Run"),
					.init(content: "Fix robot")
				  ],
				  offset: (410, 568+300))
		]
		
		return collections
	}
}
