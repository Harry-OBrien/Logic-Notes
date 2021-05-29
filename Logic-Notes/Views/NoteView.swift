//
//  NoteView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import SwiftUI

struct NoteView: View {
	
	@ObservedObject var noteVM: NoteViewModel
	
	let backgroundColour = Color(red: 253/255, green: 224/255, blue: 45/255)
	let borderColour = Color(red: 243/255, green: 216/255, blue: 46/255)
	let size = CGSize(width: 120, height: 120)

	var body: some View {
		Text(noteVM.content)
			.font(.custom("BradleyHandITCTT-Bold", size: 23))
			.frame(width: size.width, height: size.height, alignment: .center)
			.background(backgroundColour)
			.border(borderColour, width: 1.5)
	}
}

struct NoteView_Previews: PreviewProvider {
	static var previews: some View {
		NoteView(noteVM: NoteViewModel(note: Note(content: "Test note")))
	}
}

