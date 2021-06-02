//
//  BoardViewModel.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation
import SwiftUI

class BoardViewModel: ObservableObject, InterCollectionDelegate {
	
	@Published var collectionVMs: [NoteCollectionViewModel]!
	
	init() {
		getMockCollections()
		
		// TODO: Normalise offset so that the collections are centered on every device
	}
	
	private func getMockCollections() {
		let collections = Collection.getMockCollections()
		collectionVMs = collections.map { NoteCollectionViewModel(collection: $0, delegate: self) }
		print("Initialised with mock data")
	}
	
	private func newCollection(named title: String?, offset: CGPoint? = nil) -> Int {
		// Create new collection and view model
		let newTitle = (title != nil) ? title! : "New collection"
		var newCollection: Collection!
		
		// Place new collection at given offset if applicable
		if let offset = offset {
			newCollection = Collection(title: newTitle,
										   notes: [],
										   offset:(Double(offset.x), Double(offset.y)))
		} else {
			newCollection = Collection(title: newTitle, notes: [])
		}
		 
		let newVM = NoteCollectionViewModel(collection: newCollection, delegate: self)
		
		// Add collection to board
		self.collectionVMs.append(newVM)
		
		return collectionVMs.endIndex - 1
	}
	
	func add(note: Note) {
		// Create new collection and view model
		let newCollectionIndex = newCollection(named: nil)
		
		// Add collection to board
		collectionVMs[newCollectionIndex].add(note: note)
	}
	
	func move(note: Note, to dst: NoteCollectionViewModel) {
		
		// get source VM of note
		var src: NoteCollectionViewModel!
		
		for vm in collectionVMs {
			if vm.firstIndex(of: note) != nil{
				src = vm
				break
			}
		}

		guard src != nil else {
			print("Note doesn't exist anywhere...")
			return
		}
		
		if src == dst {
			print("Cannot move note between same collection")
			return
		}
		
		DispatchQueue.main.async {
			// delete from origin vm
			guard src.remove(note: note) else {
				fatalError("Note not removed from src")
			}
			
			// Delete src collection if not locked
			if src.noteViewModels.count <= 0 && !src.isLocked {
				self.deleteCollection(src)
			}
			
			// add to new vm
			dst.add(note: note)
		}
	}
	
	func deleteCollection(_ collectionViewModel: NoteCollectionViewModel) {
		collectionVMs = collectionVMs.filter { $0 != collectionViewModel }
	}

}

extension BoardViewModel: DropDelegate {
	func validateDrop(info: DropInfo) -> Bool {
		return info.hasItemsConforming(to: Note.writableTypeIdentifiersForItemProvider)
	}
	
	func performDrop(info: DropInfo) -> Bool {
		for provider in info.itemProviders(for: Note.writableTypeIdentifiersForItemProvider) {
			provider.loadObject(ofClass: Note.self) { data, error in
				if let error = error {
					print(error.localizedDescription)
					return
				}
				
				if let note = data as? Note {
					// Create new collection
					DispatchQueue.main.async {
						// remove half width, half height from offset
						
						
						let newCollectionIndex = self.newCollection(named: nil, offset: info.location)
						
						// move note
						self.move(note: note, to: self.collectionVMs[newCollectionIndex])
					}
				}
			}
		}
		
		return true
	}
}
