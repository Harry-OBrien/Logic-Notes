//
//  BoardViewModel.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation

class BoardViewModel: ObservableObject, InterCollectionDelegate {
	
	@Published var collectionVMs: [NoteCollectionViewModel]!
	
	init() {
		getMockCollections()
	}
	
	func getMockCollections() {
		let collections = Collection.getMockCollections()
		collectionVMs = collections.map {return NoteCollectionViewModel(collection: $0)}
		print("Initialised with mock data")
	}
	
	func move(note: Note, to collectionViewModel: NoteCollectionViewModel) {
		// get origin VM of note
		
		// delete from origin vm
		
		// add to new vm
		
	}
}
