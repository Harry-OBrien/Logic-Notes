//
//  NoteCollectionView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import SwiftUI
import FASwiftUI

struct NoteCollectionView: View {
	
	@ObservedObject var collectionVM: NoteCollectionViewModel
	
	private let backgroundColour = Color(white:237/255)
	private let accentColour = Color(white: 196/255)
	@State private var titleBackgroundColour = Color(white:237/255)
	private let highlightColour = Color(white: 160/255)
	
	@State private var offset = CGSize.zero
	@GestureState private var startOffset: CGSize?
	
	private let baseSize = CGSize(width: 200, height: 200)
	private var size: CGSize {
		get {
			if collectionVM.noteViewModels.count > 1 {
				let width = baseSize.width + NoteView.size.width * (CGFloat(collectionVM.noteViewModels.count) - 1)
				return CGSize(width: width, height: baseSize.height)
			}
			
			return baseSize
		}
	}
	
	@State var showOptions = false
	
	var simpleDrag: some Gesture {
		DragGesture()
			.onChanged { value in
				// Don't move if locked
				if self.collectionVM.isLocked {
					return
				}
				
				// Change title colour
				self.titleBackgroundColour = self.highlightColour
				
				var newOffset = startOffset ?? offset
				newOffset.width += value.translation.width
				newOffset.height += value.translation.height
				self.offset = newOffset
			}
			.updating($startOffset) { (value, startOffset, transaction) in
				startOffset = startOffset ?? offset
			}
			.onEnded { value in
				self.titleBackgroundColour = self.backgroundColour
			}
	}
	
	init(collectionVM: NoteCollectionViewModel) {
		self.collectionVM = collectionVM
	}
	
	var body: some View {
		GeometryReader { g in
			VStack(alignment: .center, spacing: 0) {
				if showOptions {
					optionsHStack()
				}
				else {
					optionsHStack().hidden()
				}
				collectionHeader(titled: collectionVM.title)
				noteContainer(collectionVM.noteViewModels)
			}
			.position(collectionVM.initialPosition)
			.offset(offset)
			.gesture(simpleDrag)
			.onDrop(of: Note.writableTypeIdentifiersForItemProvider, delegate: self.collectionVM)
			.onTapGesture {
				self.showOptions.toggle()
			}
		}
	}

	private func optionsHStack() -> some View {
		VStack(alignment: .center, spacing: 0) {
			HStack (spacing: 50) {
				Button(action: {
					withAnimation {
						collectionVM.deleteCollection()
					}
				}, label: {
					FAText(iconName: "trash-alt", size: 32)
				})
				
				Button(action: {
					collectionVM.isLocked.toggle()
				}, label: {
					lockIcon(locked: collectionVM.isLocked)
				})
			}
			.foregroundColor(Color(white: 245/255))
			.frame(width: 200, height: 60, alignment: .center)
			.background(Color(white: 44/255))
			.cornerRadius(6)
			
			Triangle()
				.fill(Color(white: 44/255))
				.frame(width: 30, height: 15, alignment: .center)
		}
		.offset(y: 30)
		.zIndex(1.0)
		
	}
	
	private func lockIcon(locked: Bool) -> some View {
		locked ? FAText(iconName: "lock", size: 32) : FAText(iconName: "unlock", size: 32)
	}
	
	private func collectionHeader(titled title: String) -> some View {
		Text(title)
			.font(Font.title)
			.frame(minWidth: 180, idealWidth: 180, maxWidth: size.width, minHeight: 60, maxHeight: 60)
			.background(showOptions ? highlightColour : titleBackgroundColour)
			.cornerRadius(30)
			.overlay(RoundedRectangle(cornerRadius: 30)
						.stroke(accentColour))
			.offset(y: 30)
			.zIndex(1.0)
	}
	
	private func noteContainer(_ noteVMs: [NoteViewModel]) -> some View {
		HStack {
			ForEach(noteVMs) { noteVM in
				NoteView(noteVM: noteVM)
					.onDrag {
						NSItemProvider(object: noteVM.note)
					}
			}
			
		}
		.frame(width: size.width,
			   height: size.height,
			   alignment: .center)
		.padding()
		.background(backgroundColour)
		.cornerRadius(6)
		.overlay(
			RoundedRectangle(cornerRadius: 6)
				.stroke(accentColour)
		)
	}
}

struct NoteCollectionView_Previews: PreviewProvider {
	static var previews: some View {
		let collection = Collection(title: "Test collection",
									notes: [
										.init(content: "Test Note"),
										.init(content: "Test Note"),
										.init(content: "Test Note")
									])
		let vm = NoteCollectionViewModel(collection: collection, delegate: nil)
		NoteCollectionView(collectionVM: vm)
	}
}
