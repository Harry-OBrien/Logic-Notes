//
//  NoteCollectionViewModel.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation
import SwiftUI

class NoteCollectionViewModel: ObservableObject, Identifiable, Equatable {
	private(set) var id = UUID()
	
	private var collection: Collection {
		didSet {
			var newNoteViewModels = [NoteViewModel]()
			for note in collection.notes {
				newNoteViewModels.append(NoteViewModel(note: note))
			}
			
			self.noteViewModels = newNoteViewModels
		}
	}
	
	private var delegate: InterCollectionDelegate?
	
	@Published private(set) var title: String
	@Published private(set) var noteViewModels: [NoteViewModel]!
	@Published var isLocked : Bool
	let initialPosition: CGPoint
	
	init(collection: Collection, delegate: InterCollectionDelegate?) {
		self.collection = collection
		self.title = collection.title
		self.isLocked = collection.locked
		self.initialPosition = CGPoint(x: collection.offset.0, y: collection.offset.1)
		
		self.setNoteViewModels(notes: collection.notes)
		self.delegate = delegate
	}
	
	private func setNoteViewModels(notes: [Note]) {
		self.noteViewModels = notes.map({return NoteViewModel(note: $0)})
	}
	
	func add(note: Note) {
		collection.notes.append(note)
	}
	
	func remove(note: Note) -> Bool {
		
		guard let idx = firstIndex(of: note) else {
			return false
		}
		
		collection.notes.remove(at: idx)
		
		return true
	}
	
	func firstIndex(of note: Note) -> Int? {
		return collection.notes.firstIndex { (internalNote) -> Bool in
			internalNote.id == note.id
		}
	}
	
	func deleteCollection() {
		if let delegate = self.delegate {
			delegate.deleteCollection(self)
		}
		else {
			print("Unable to delete collection... No delegate set.")
		}
	}
	
	static func == (lhs: NoteCollectionViewModel, rhs: NoteCollectionViewModel) -> Bool {
		lhs.id == rhs.id
	}
}

// MARK: Drop delegate
extension NoteCollectionViewModel: DropDelegate {
	
	func validateDrop(info: DropInfo) -> Bool {
		return info.hasItemsConforming(to: Note.writableTypeIdentifiersForItemProvider)
	}
	
	func dropEntered(info: DropInfo) {
//		for provider in info.itemProviders(for: Note.writableTypeIdentifiersForItemProvider) {
//			provider.loadObject(ofClass: Note.self) { data, error in
//				if let error = error {
//					print(error.localizedDescription)
//					return
//				}
//
//				if let note = data as? Note {
//					// move note
//					if let delegate = self.delegate {
//						delegate.move(note: note, to: self)
//					}
//				}
//			}
//		}
	}
	
	func performDrop(info: DropInfo) -> Bool {
		for provider in info.itemProviders(for: Note.writableTypeIdentifiersForItemProvider) {
			provider.loadObject(ofClass: Note.self) { data, error in
				if let error = error {
					print(error.localizedDescription)
					return
				}
				
				if let note = data as? Note {
					// move note
					if let delegate = self.delegate {
						delegate.move(note: note, to: self)
					}
				}
			}
		}
		
		return true
	}
}
