//
//  InterCollectionDelegate.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 29/05/2021.
//

import Foundation

protocol InterCollectionDelegate {
	func move(note: Note, to collectionViewModel: NoteCollectionViewModel)
	
	func deleteCollection(_ collectionViewModel: NoteCollectionViewModel)
}
