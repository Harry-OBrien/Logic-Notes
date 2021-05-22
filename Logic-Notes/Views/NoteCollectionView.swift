//
//  NoteCollectionView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import SwiftUI

struct NoteCollectionView: View {
	
	@ObservedObject var collectionVM: NoteCollectionViewModel
	
	private let backgroundColour = Color(white:237/255)
	private let accentColour = Color(white: 196/255)
	@State private var titleBackgroundColour = Color(white:237/255)
	private let highlightColour = Color(white: 160/255)
	
	@State private var offset = CGSize.zero
	@GestureState private var startOffset: CGSize?
	
	var simpleDrag: some Gesture {
		DragGesture()
			.onChanged { value in
				// Change title colour
				self.titleBackgroundColour = self.highlightColour
				
				var newOffset = startOffset ?? offset
				newOffset.width += value.translation.width
				newOffset.height += value.translation.height
				self.offset = newOffset
			}.updating($startOffset) { (value, startOffset, transaction) in
				startOffset = startOffset ?? offset
			}
			.onEnded { value in
				self.titleBackgroundColour = self.backgroundColour
			}
	}
	
	var body: some View {
		VStack {
			Text(collectionVM.title)
				.font(Font.title)
				.frame(width: 180, height: 60, alignment: .center)
				.background(titleBackgroundColour)
				.cornerRadius(30)
				.overlay(RoundedRectangle(cornerRadius: 30)
							.stroke(accentColour))
				.offset(y: 30)
				.zIndex(1.0)
			
			HStack {
				ForEach(collectionVM.noteViewModels) { noteVM in
					NoteView(noteVM: noteVM)
				}
			}
			.frame(width: collectionVM.size.width,
				   height: collectionVM.size.height,
				   alignment: .center)
			.background(backgroundColour)
			.cornerRadius(6)
			.overlay(
				RoundedRectangle(cornerRadius: 6)
					.stroke(accentColour)
			)
		}
		.offset(offset)
		.gesture(simpleDrag)
	}
}

struct NoteCollectionView_Previews: PreviewProvider {
	static var previews: some View {
		NoteCollectionView(collectionVM: NoteCollectionViewModel(collection: Collection(
																	title: "Test collection",
																	notes: [
																		.init(content: "Test Note")
																	]
		)))
	}
}
