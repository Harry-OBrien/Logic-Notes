//
//  NoteCollectionViewModel.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation
import SwiftUI

class NoteCollectionViewModel: ObservableObject, Identifiable, Equatable, DropDelegate {
	func performDrop(info: DropInfo) -> Bool {
		for provider in info.itemProviders(for: NoteViewModel.writableTypeIdentifiersForItemProvider) {
			provider.loadObject(ofClass: NoteViewModel.self) { data, error in
				if let error = error {
					print(error.localizedDescription)
					return
				}
				
				if let noteVm = data as? NoteViewModel {
					// add noteVM to collection
					DispatchQueue.main.async {
						self.noteViewModels.append(noteVm)
					}
				}
			}
		}
		
		return true
	}
	
	static func == (lhs: NoteCollectionViewModel, rhs: NoteCollectionViewModel) -> Bool {
		lhs.id == rhs.id
	}
	
	var id = UUID()
	
	private var collection: Collection
	
	@Published var title: String
	
	// TODO: Move this into view
	@Published var size: CGSize!
	let padding: CGFloat = 10
	let marginWidth: CGFloat = 50
	
	@Published var noteViewModels: [NoteViewModel]! {
		didSet {
			// Check that we have at least one note
			guard noteViewModels.count > 0 else {
				self.size = CGSize(width: 150 + marginWidth, height: 220)
				return
			}
			
			// Update the size of the collection
			let note_width = noteViewModels[0].size.width + self.padding
			let newWidth: CGFloat = note_width * CGFloat(noteViewModels.count) + marginWidth
			self.size = CGSize(width: newWidth, height: 220)
		}
	}
	
	init(collection: Collection) {
		self.collection = collection
		self.title = collection.title
		self.setNoteViewModels(notes: collection.notes)
	}
	
	private func setNoteViewModels(notes: [Note]) {
		self.noteViewModels = notes.map({return NoteViewModel(note: $0)})
	}
	
//	func remove(note: Note) -> Bool {
//
//		// create new collection without given note
//		let filteredNotes = collection.notes.filter { $0 != note }
//
//		// Check that we removed the note successfully
//		guard filteredNotes.count == (collection.notes.count - 1) else {
//			print("Note not removed. Did it even exist in this collection?")
//			return false
//		}
//
//		// set our notes collection to the filtered collection
//		collection.notes = filteredNotes
//
//		return true
//	}
//
//	func add(note: Note) {
//		collection.notes.append(note)
//	}
//
//	func add(notes: [Note]) {
//		collection.notes.append(contentsOf: notes)
//	}
//
//	func clear() {
//		collection.notes = []
//	}
}
