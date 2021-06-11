//
//  NoteDetailView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 01/06/2021.
//

import SwiftUI

struct NoteDetailView: View {
	@State private var content = ""
	private let onComplete: (String) -> Void
	private let onCancel: () -> Void
	private let updating: Bool
	
	init(content: String = "", onComplete: @escaping (String) -> Void, onCancel: @escaping () -> Void) {
		self.content = content
		self.onComplete = onComplete
		self.onCancel = onCancel
		
		if !content.isEmpty {
			self.updating = true
		} else {
			self.updating = false
		}
	}
	
	var body: some View {
		VStack {
			// Top bar
			HStack {
				
				Button(action: {
					onCancel()
				}, label: {
					Text("Cancel")
						.font(.title2)
				})
				.padding()
				.frame(maxWidth: .infinity, alignment: .leading)
				
				Text(updating ? "Edit Note" : "New Note")
					.font(.title)
					.foregroundColor(.black)
				
				Button(action: {
					onComplete(content)
				}, label: {
					if updating {
						Text("Save")
							.font(.title2)
					}
					else {
						Image(systemName: "plus")
							.font(.title2)
					}
				})
				.padding()
				.frame(maxWidth: .infinity, alignment: .trailing)
			}
			.foregroundColor(Color(red: 245 / 255, green: 169/255, blue: 2/255))
			.frame(maxWidth: .infinity, minHeight: 60)
			GeometryReader { g in
				
				VStack {
					NoteView(noteText: content)
						.frame(maxWidth: .infinity, maxHeight: g.size.height / 4, alignment: .center)
						.scaleEffect(g.size.height / 500)
					
					
					VStack(alignment: .leading) {
						Text("Content:")
							.font(.title3.bold())
						TextField("Content", text: $content)
							.frame(width: 400, alignment: .center)
							.textFieldStyle(RoundedBorderTextFieldStyle())
					}
					
				}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			}
		}
		.background(Color.white)
	}
}


//struct ActionButtons: View {
//
//	var body: some View {
//
//	}
//}



struct AddNote_Previews: PreviewProvider {
	static var previews: some View {
		NoteDetailView { _ in
			
		} onCancel: {
			
		}
		
		NoteDetailView(content: "Hello world!") { text in
			
		} onCancel: {
			
		}
		
	}
}
