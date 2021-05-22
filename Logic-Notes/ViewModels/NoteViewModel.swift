//
//  NoteViewModel.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation
import SwiftUI

class NoteViewModel: ObservableObject, Identifiable {
	let id = UUID()
	
	@Published var content: String
	let size = CGSize(width: 120, height: 120)
	
	init(note: Note) {
		self.content = note.content
	}
	
}
