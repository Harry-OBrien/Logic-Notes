//
//  BoardViewModel.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation

class BoardViewModel: ObservableObject {
	
	@Published var collectionVMs = [NoteCollectionViewModel]()
	
	init() {
		getMockCollections()
	}
	
	func getMockCollections() {
		let collections = Collection.getMockCollections()
		collectionVMs = collections.map {return NoteCollectionViewModel(collection: $0)}
		print("Initialised with mock data")
	}
	
	func move(note movingNote: Note, from vm1: NoteCollectionViewModel, to vm2: NoteCollectionViewModel) -> Bool {
		guard vm1 != vm2 else {
			print("Cannot move note between same collection")
			return false
		}
		
		// remove note from collection 1
		guard vm1.remove(note: movingNote) else {
			return false
		}

		// add note to collection 2
		vm2.add(note: movingNote)


		return true
	}
	
	func combine(_ vm1: NoteCollectionViewModel, into vm2: NoteCollectionViewModel) {
		guard vm1 != vm2 else {
			print("Cannot move note between same collection")
			return
		}
		
		vm1.add(notes: vm2.collection.notes)
		vm2.clear()
	}
}
