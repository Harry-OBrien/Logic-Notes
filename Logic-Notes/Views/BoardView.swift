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
*/

struct BoardView: View {
	
	@ObservedObject var boardVM = BoardViewModel()
	
	var body: some View {
		VStack {
			ForEach(boardVM.collectionVMs) { collectionVM in
				NoteCollectionView(collectionVM: collectionVM)
			}
		}
		.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
	}
}

struct BoardView_Previews: PreviewProvider {
	static var previews: some View {
		BoardView()
	}
}
