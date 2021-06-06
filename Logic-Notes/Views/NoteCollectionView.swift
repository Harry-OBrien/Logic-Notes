//
//  NoteCollectionView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import SwiftUI
import FASwiftUI

struct NoteCollectionView: View {
	
	@ObservedObject var document: BoardDocument
	let collection: Board.Collection
	
	@State private var showOptions = false
	
	private var notes: [Board.Collection.Note] {
		collection.notes
	}
	
	private var locked: Bool {
		collection.locked
	}
	
	// Colours
	private let backgroundColour = Color(white:237/255)
	private let accentColour = Color(white: 196/255)
	private let highlightColour = Color(white: 160/255)
	private let lockedHighlightColour = Color(red: 215/255, green: 58/255, blue: 74/255)
	
	
	// Sizing
	private let baseSize = CGSize(width: 200, height: 200)
	var zoomScale: CGFloat
	private var size: CGSize {
		get {
			// More than 1 note: expand the width
			if notes.count > 1 {
				let width = baseSize.width + NoteView.size.width * (CGFloat(collection.notes.count) - 1)
				return CGSize(width: width, height: baseSize.height)
			}
			
			// Only 1 note, return the base size
			return baseSize
		}
	}
	
	// Drag
	@GestureState private var gestureDragOffset: CGSize = .zero
	@State private var dragging = false
	
	var drag: some Gesture {
		DragGesture()
			.onChanged { value in
				dragging = true
			}
			.updating($gestureDragOffset) { (latestDragValue, gestureDragOffset, transaction) in
				// Don't move if locked
				if self.locked {
					return
				}
				
				gestureDragOffset = latestDragValue.translation
			}
			.onEnded { value in
				dragging = false
				if !self.locked {
					document.moveCollection(collection, by: value.translation / zoomScale)
				}
			}
	}
	
	var body: some View {
		VStack(alignment: .center, spacing: 0) {
			optionsStack(locked: collection.locked,
						 onToggle: { document.toggleCollectionLocked(collection) },
						 onDelete: { document.removeCollection(collection) })
				.Hide(!showOptions)
			
			// Collection Header
			Text(collection.title)
				.padding()
				.font(Font.title)
				.frame(minWidth: 180, minHeight: 60, maxHeight: 60, alignment: .center)
				.background(showOptions || dragging ? highlightColour : backgroundColour)
				.cornerRadius(30)
				.overlay(RoundedRectangle(cornerRadius: 30)
							.stroke(dragging && locked ? lockedHighlightColour : accentColour))
				.offset(y: 30)
				.zIndex(1.0)
				.fixedSize()
			
			// Note Container
			HStack {
				ForEach(notes) { note in
					NoteView(noteText: note.text)
						.onDrag {
							NSItemProvider(object: note)
						}
//						.onTapGesture {
//
//						}
				}
			}
			.frame(width: size.width, height: size.height, alignment: .center)
			.padding()
			.background(backgroundColour)
			.cornerRadius(6)
			.overlay(
				RoundedRectangle(cornerRadius: 6)
					.stroke(dragging && locked ? lockedHighlightColour : accentColour)
			)
		}
		.scaleEffect(zoomScale)
		.offset(gestureDragOffset)
		.gesture(drag)
		.onTapGesture {
			self.showOptions.toggle()
		}
		.onDrop(of: Board.Collection.Note.writableTypeIdentifiersForItemProvider, isTargeted: nil, perform: { providers, _ in
					self.drop(providers: providers)
		})
	}
	
	struct optionsStack: View {
		var locked: Bool
		var onToggle: () -> Void
		var onDelete: () -> Void
		
		private let iconSize: CGFloat = 32
		
		var body: some View {
			VStack(alignment: .center, spacing: 0) {
				HStack (spacing: 50) {
					Button(action: {
						withAnimation {
							onDelete()
						}
					}, label: {
						FAText(iconName: "trash-alt", size: iconSize)
					})
					
					Button(action: {
						onToggle()
					}, label: {
						Group {
							if locked {
								FAText(iconName: "lock", size: iconSize)
							}
							else {
								FAText(iconName: "unlock", size: iconSize)
							}
						}
					})
					
					Button(action: {
						print("edit btn pressed")
					}, label: {
						FAText(iconName: "pencil-alt", size: iconSize)
					})
				}
				.foregroundColor(Color(white: 245/255))
				.frame(width: 210, height: 60, alignment: .center)
				.background(Color(white: 44/255))
				.cornerRadius(6)
				
				Triangle()
					.fill(Color(white: 44/255))
					.frame(width: 30, height: 15, alignment: .center)
			}
			.offset(y: 30)
			.zIndex(1.0)
		}
	}
	
	private func drop(providers: [NSItemProvider]) -> Bool {
		let found = providers.loadFirstObject(ofType: Board.Collection.Note.self) { note in
			document.moveNote(note, to: collection)
		}
		
		return found
	}
}
