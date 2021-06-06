//
//  BoardView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import SwiftUI
import FASwiftUI

struct BoardView: View {
	
	@ObservedObject private var document: BoardDocument
	
	@GestureState private var gestureZoomScale: CGFloat = 1.0
	@GestureState private var gesturePanOffset: CGSize = .zero
	
	@State private var addNotePresented = false
	
	private var zoomScale: CGFloat { document.steadyStateZoomScale * gestureZoomScale}
	private var panOffset: CGSize { (document.steadyStatePanOffset + gesturePanOffset) * zoomScale }
	
	init(board: Board) {
		document = BoardDocument(board: board)
		
		
	}
	
	private func zoomToFit() {
		
	}
	
	var body: some View {
		GeometryReader { geometry in
			ZStack() {
				ForEach(document.collections) { collection in
					NoteCollectionView(document: document, collection: collection, zoomScale: zoomScale)
						.transition(.opacity)
						.position(self.position(for: collection, in: geometry.size))
				}
				
				Button(action: {
					print("new button pressed")
					addNotePresented.toggle()
				}, label: {
					HStack {
						FAText(iconName: "plus", size: 24)
						Text("Create")
							.font(.title2.bold())
					}
					
				})
				.frame(width: 130, height: 60, alignment: .center)
				.foregroundColor(.white)
				.background(Color(white: 0.1))
				.cornerRadius(30)
				.position(x: geometry.size.width - 65, y: geometry.size.height - 30)
			}
			.background(Color.white)
			.onDrop(of: Board.Collection.Note.writableTypeIdentifiersForItemProvider, isTargeted: nil, perform: { providers, location in
				var location = geometry.convert(location, from: .global)
				location = CGPoint(x: location.x - geometry.size.width / 2, y: location.y - geometry.size.height / 2)
				location = CGPoint(x: location.x - self.panOffset.width, y: location.y - self.panOffset.height)
				location = CGPoint(x: location.x / self.zoomScale, y: location.y / self.zoomScale)
				return self.drop(providers: providers, at: location)
			})
			.gesture(self.doubleTapToZoom(in: geometry.size))
			.onAppear {
				zoomToFit(in: geometry.size)
			}
		}
		.gesture(self.panGesture())
		.gesture(self.zoomGesture())
		.edgesIgnoringSafeArea([.horizontal, .bottom])
//		.onDrop(of: Note.writableTypeIdentifiersForItemProvider, delegate: self.boardVM)
		.sheet(isPresented: $addNotePresented) {
			NoteDetailView { newNoteContent in
				document.addNote(newNoteContent)
				addNotePresented.toggle()
			} onCancel: {
				addNotePresented.toggle()
			}
		}
	}
	
	private func panGesture() -> some Gesture {
		DragGesture()
			.updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, transaction in
				gesturePanOffset = latestDragGestureValue.translation / self.zoomScale
			}
			.onEnded { finalDragGestureValue in
				self.document.steadyStatePanOffset = self.document.steadyStatePanOffset + (finalDragGestureValue.translation / self.zoomScale)
			}
	}
	
	private func zoomGesture() -> some Gesture {
		MagnificationGesture()
			.updating($gestureZoomScale) { latestGestureScale, inOutGestureState, transaction in
				inOutGestureState = latestGestureScale
			}
			.onEnded { (finalGestureScale) in
				self.document.steadyStateZoomScale *= finalGestureScale
			}
	}
	
	private func doubleTapToZoom(in size: CGSize) -> some Gesture {
		TapGesture(count: 2)
			.onEnded {
				withAnimation {
					self.zoomToFit(in: size)
				}
			}
	}
	
	private func zoomToFit(in size: CGSize) {
		document.recenterCollections()
		let bounds = document.boundingBox
	
		let hZoom = bounds.width / size.width
		let vZoom = bounds.height / size.height
		
		self.document.steadyStatePanOffset = .zero
		
//		print(1/hZoom, hZoom, 1/vZoom, vZoom)
		self.document.steadyStateZoomScale = max(min(1/hZoom, hZoom), min(1/vZoom, vZoom)) * 0.9
	}
	
	private func position(for collection: Board.Collection, in size: CGSize) -> CGPoint {
		var location = collection.location
		location = CGPoint(x: location.x * zoomScale, y: location.y * zoomScale)
		location = CGPoint(x: location.x + size.width/2, y: location.y + size.height/2)
		location = CGPoint(x: location.x + self.panOffset.width, y: location.y + self.panOffset.height)
		
		return location
	}
	
	private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool {
		let found = providers.loadFirstObject(ofType: Board.Collection.Note.self) { note in
			document.addNote(note, at: location)
		}
		
		return found
	}
}

struct BoardView_Previews: PreviewProvider {
	static var previews: some View {
		BoardView(board: Board.getMockBoard2())
	}
}
