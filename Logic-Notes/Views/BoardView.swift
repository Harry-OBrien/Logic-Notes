//
//  BoardView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import SwiftUI
import FASwiftUI

struct BoardView: View {
	
	@ObservedObject private var boardVM = BoardViewModel()
	@State private var isPresented = false
	
	var body: some View {
		
		ZStack(alignment: .myAlignment) {
			withAnimation {
				ForEach(boardVM.collectionVMs) { collectionVM in
					NoteCollectionView(collectionVM: collectionVM)
						.transition(.scale)
				}
			}
			GeometryReader { g in
				Button(action: {
					print("new button pressed")
					isPresented.toggle()
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
				.position(x: g.size.width - 65, y: g.size.height - 30)
			}
			.padding()
		}
		.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
		.edgesIgnoringSafeArea([.horizontal, .bottom])
		.background(Color.white)
		.onDrop(of: Note.writableTypeIdentifiersForItemProvider, delegate: self.boardVM)
		.sheet(isPresented: $isPresented) {
			AddNote { noteContent in
				let newNote = Note(content: noteContent)
				boardVM.add(note: newNote)
			}
		}
	}
}

struct BoardView_Previews: PreviewProvider {
	static var previews: some View {
		BoardView()
	}
}
