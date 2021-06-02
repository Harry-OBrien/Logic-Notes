//
//  AddNote.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 01/06/2021.
//

import SwiftUI

struct AddNote: View {
	@State var content = ""
	let onComplete: (String) -> Void
	
    var body: some View {
		Form {
			Section(header: Text("Content")) {
				TextField("Content", text: $content)
			}
			Section {
				Button(action: addNoteAction) {
					Text("Add Note")
				}
			}
		}
    }
	
	private func addNoteAction() {
		onComplete(content.isEmpty ? "" : content)
	}
}
