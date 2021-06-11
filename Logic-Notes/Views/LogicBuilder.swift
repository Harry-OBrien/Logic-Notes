//
//  LogicBuilder.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 07/06/2021.
//

import SwiftUI

struct LogicBuilder: View {
	@EnvironmentObject var document: BoardDocument
	
    var body: some View {
		Text(document.boardTitle)
    }
}

struct ComponentListView: View {
	
	var body: some View {
		List(0..<50) { i in
			Text("Index \(i)")
		}
	}
}

struct LogicDetailView: View {
	
	var body: some View {
		Text("detail")
	}
}

struct LogicBuilder_Previews: PreviewProvider {
    static var previews: some View {
		let document = BoardDocument(board: Board.getMockBoard2())
		
		LogicBuilder()
			.environmentObject(document)
    }
}
