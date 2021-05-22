//
//  BoardView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import SwiftUI

/*
TODO:
	Group the collections into a single scrollable (horizontal and vertical) and zoomable view
	Move note from collection to another
	Modify collection view to use an actual grid instead of hoping autoLayout does its job

	LOOK AT YOUTUBE VID TO SEE HOW TO MOVE NOTES PROPERLY
*/

struct BoardView: View {
	
	@ObservedObject var boardVM = BoardViewModel()
	
	var body: some View {
		ZStack {
			ForEach(boardVM.collectionVMs) { collectionVM in
				NoteCollectionView(collectionVM: collectionVM)
					.frame(alignment: .center)
					.padding()
			}
//			Button("Move note") {
//				let success = boardVM.move(note: boardVM.collectionVMs[0].getNote(0), from: boardVM.collectionsVms[0], to: boardVM.collectionVms[0])
//				print("Move \(success ? "success" : "fail")")
//			}
			.frame(alignment: .bottomTrailing)
			.background(Color(red: 0, green: 1, blue: 1))
		}.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		BoardView()
	}
}
