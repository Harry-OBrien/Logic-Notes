//
//  Collection.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation

struct Collection: Identifiable, Equatable {
	let id = UUID()
	var title: String
	var notes: [Note]
}

extension Collection{
	static func getMockCollections() -> [Collection] {
		
		let collections: [Collection] = [
			.init(title: "Group A",
				  notes: [
					.init(content: "Note 1"),
					.init(content: "Note 2"),
					.init(content: "Note 3"),
				  ]),
			.init(title: "Group B",
				  notes: [
					.init(content: "Note 4"),
					.init(content: "Note 5")
				  ]),
			.init(title: "Group C",
				  notes: [
					.init(content: "Note 6"),
					.init(content: "Note 7"),
					.init(content: "Note 8"),
					.init(content: "Note 9")
				  ])
		]
		
		return collections
	}
}
