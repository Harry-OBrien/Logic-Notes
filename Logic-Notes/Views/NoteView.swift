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
	
//	@State private var offset = CGSize.zero
//	@GestureState private var startOffset: CGSize?
	
//	var simpleDrag: some Gesture {
//		DragGesture()
//			.onChanged { value in
//				var newOffset = startOffset ?? offset
//				newOffset.width += value.translation.width
//				newOffset.height += value.translation.height
//				self.offset = newOffset
//			}.updating($startOffset) { (value, startOffset, transaction) in
//				startOffset = startOffset ?? offset
//			}
//	}
	
	var body: some View {
		Text(noteVM.content)
			.font(.custom("BradleyHandITCTT-Bold", size: 23))
			.frame(width: noteVM.size.width, height: noteVM.size.height, alignment: .center)
			.background(backgroundColour)
			.border(borderColour, width: 1.5)
//			.gesture(simpleDrag)
//			.offset(offset)
	}
}

struct NoteView_Previews: PreviewProvider {
	static var previews: some View {
		NoteView(noteVM: NoteViewModel(note: Note(content: "Test note")))
	}
}

