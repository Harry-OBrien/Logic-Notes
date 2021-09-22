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
	
	init(board: BoardDocument) {
		self.boardDocument = board
		self.logicBackend = LogicToBoardInterface(board: board)
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
				Group {
					// Menu toggle button
					Image(systemName: "lessthan.circle")
						.rotationEffect(Angle(degrees: showMenu ? 0 : 180))
						.frame(width: 26, height: 180, alignment: .center)
						.foregroundColor(.white)
						.background(RoundedCorners(color: Color(white: 54/255), tl: 0, tr: 15, bl: 0, br: 15))
						.position(x: 13, y: geometry.size.height/2)
						.onTapGesture(count: 1, perform: {
							withAnimation {
								self.showMenu.toggle()
							}
						})
					
					// Main logic builder interfae
					LogicBuilderView()
						.environmentObject(logicBackend)
						.disabled(showMenu ? true : false)
						.opacity(showMenu ? 0.3 : 1)
				}
				.frame(width: geometry.size.width, height: geometry.size.height)
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
		let board = BoardDocument(board: Board.mockBoard1)
		LogicBoardContainerView(board: board)
	}
}
