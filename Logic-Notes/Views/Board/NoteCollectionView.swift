//
//  NoteCollectionView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import SwiftUI

struct NoteCollectionView: View {
	
	@EnvironmentObject var document: BoardDocument
	let collection: Board.Collection
	
	@State private var showOptions = false
	@FocusState private var editingCollectionTitle: Bool
	
	private var notes: [Board.Collection.Note] {
		collection.notes
	}
	
	private var locked: Bool {
		collection.locked
	}
	
	// MARK: Colours
	private let backgroundColour = Color(white:237/255)
	private let accentColour = Color(white: 196/255)
	private let highlightColour = Color(white: 160/255)
	private let lockedHighlightColour = Color(red: 215/255, green: 58/255, blue: 74/255)
	
	// MARK: Sizing
	private let baseSize = CGSize(width: 200, height: 200)
	var zoomScale: CGFloat
	private var size: CGSize {
		get {			
			// More than 1 note: expand the width
			if notes.count > 1 {
				let width = baseSize.width + NoteView.size.width * (CGFloat(collection.notes.count) - 1)
				return CGSize(width: width, height: baseSize.height)
			}
			
			// Only 1 note: return the base size
			return baseSize
		}
	}
	
	// MARK: Drag
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
	
	// MARK: Body
	var body: some View {
		VStack(alignment: .center, spacing: 0) {
			// Collection Header
			EditableText(collection.id, focused: $editingCollectionTitle) { name in
				do {
					try document.renameCollection(collection, to: name)
				}
				catch {
					
				}
				editingCollectionTitle = false
				showOptions = false
			}
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
							NSItemProvider(object: "\(self.collection.id):" + note.text as NSString)
						}
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
		.onDrop(of: [.text], isTargeted: nil, perform: { providers, _ in
			self.drop(providers: providers)
		})
		.popover(isPresented: $showOptions) {
			OptionsStack(locked: collection.locked,
						 onToggle: { document.toggleCollectionLocked(collection) },
						 onDelete: { document.deleteCollection(collection) },
						 editing: $editingCollectionTitle
			)
		}
	}
	
	// MARK: Drop
	private func drop(providers: [NSItemProvider]) -> Bool {
		let found = providers.loadFirstObject(ofType: String.self) { noteContent in
			print(noteContent)
			//			boardDocument.moveNote(...)
		}
		
		return found
	}
	
	// MARK: Options Stack
	private struct OptionsStack: View {
		var locked: Bool
		var onToggle: () -> Void
		var onDelete: () -> Void
		
		@State var showDeleteAlert = false
		var editing: FocusState<Bool>.Binding
		
		var body: some View {
			HStack (spacing: 10) {
				Button(action: {
					showDeleteAlert = true
				}, label: {
					Image(systemName: "trash")
						.font(.title)
						.alert(isPresented: $showDeleteAlert) {
							Alert(title: Text("Delete collection?"),
								  message: Text("Are you sure you want to delete this collection"),
								  primaryButton: .cancel(),
								  secondaryButton: .destructive(Text("Delete")) {
								withAnimation {
									onDelete();
								}
							}
							)
						}
				})
				
				Divider().background(Color.white)
				
				Button(action: {
					onToggle()
				}, label: {
					Group {
						if locked {
							Image(systemName: "lock.fill")
								.font(.title)
						}
						else {
							Image(systemName: "lock.open.fill")
								.font(.title)
						}
					}
				})
				
				Divider().background(Color.white)
				
				Button(action: {
					print("edit btn pressed")
					editing.wrappedValue = true
					
				}, label: {
					Image(systemName: "pencil")
						.font(.title)
				})
				
				Divider().background(Color.white)
				
				Button(action: {
					print("freeform pressed")
				}, label: {
					Image("icon-layout-freeform")
						.font(.title)
				})
				
				Button(action: {
					print("snaptogrid pressed")
				}, label: {
					Image("icon-layout-snaptogrid")
						.font(.title)
				})
				
				Button(action: {
					print("snap pressed")
				}, label: {
					Image("icon-layout-autolayout")
						.font(.title)
				})
				
			}
			.foregroundColor(Color(white: 245/255))
			.frame(width: 300, height: 60, alignment: .center) //210
			.background(Color(white: 44/255))
			.cornerRadius(6)
		}
	}
}
