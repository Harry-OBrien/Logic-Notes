//
//  NoteViewModel.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation
import SwiftUI

final class NoteViewModel: ObservableObject, Identifiable {
	
	let id = UUID()

	private(set) var note: Note
	@Published var content: String
	
	init(note: Note) {
		self.note = note
		self.content = note.content
	}
}
