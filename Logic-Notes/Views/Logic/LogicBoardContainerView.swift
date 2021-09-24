//
//  LogicBoardContainerView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 07/06/2021.
//

import SwiftUI

struct LogicBoardContainerView: View {
	@ObservedObject private var boardDocument: BoardDocument
	@ObservedObject private var logicBackend: LogicToBoardInterface
	@State private var showMenu = false
	
	init(document: BoardDocument) {
		self.boardDocument = document
		self.logicBackend = LogicToBoardInterface(boardDocument: document)
	}
	
	var closingDragGesture: some Gesture {
		DragGesture()
			.onEnded {
				if $0.translation.width < -100 {
					withAnimation {
						self.showMenu = false
					}
				}
			}
	}
	
	var body: some View {
		GeometryReader { geometry in
			ZStack(alignment: .leading) {
				// Main logic builder interface
				LogicBuilderView()
					.environmentObject(logicBackend)
					.disabled(showMenu ? true : false)
					.opacity(showMenu ? 0.3 : 1)
				
				// Menu toggle button
				Button {
					withAnimation {
						self.showMenu.toggle()
					}
				} label: {
					Image(systemName: "lessthan.circle")
						.frame(width: 26, height: 180, alignment: .center)
						.rotationEffect(Angle(degrees: showMenu ? 0 : 180))
						.foregroundColor(.white)
						.background(RoundedCorners(color: Color(white: 54/255), tl: 0, tr: 15, bl: 0, br: 15))
				}
				.position(x: 13, y: geometry.size.height/2)
				.offset(x: showMenu ? menuSizeIn(geometry: geometry) : 0)
				
				if self.showMenu {
					ComponentListView()
						.frame(width: menuSizeIn(geometry: geometry))
						.transition(.move(edge: .leading))
				}
			}
			.gesture(closingDragGesture)
		}
	}
	
	private func menuSizeIn(geometry: GeometryProxy) -> CGFloat {
		return 5 * geometry.size.width/8
	}
}

struct LogicBuilder_Previews: PreviewProvider {
	static var previews: some View {
		let board = BoardDocument(board: Board.mockBoard)
		LogicBoardContainerView(document: board)
	}
}
