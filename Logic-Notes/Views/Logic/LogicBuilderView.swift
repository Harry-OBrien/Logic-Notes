//
//  LogicBuilderView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 23/06/2021.
//

import SwiftUI

struct LogicBuilderView: View {
	
	@EnvironmentObject private var logicBackend: LogicToBoardInterface
	
	var body: some View {
		GeometryReader { geometry in
			ZStack(alignment: .center) {
				Group {
					if logicBackend.programs.isEmpty {
						Text("Drag logic blocks here to build something awesome!")
					}
					else {
						ForEach(logicBackend.programs) { program in
							ProgramView(program: program)
						}
					}
				}
				.edgesIgnoringSafeArea([.horizontal, .bottom])
				.onDrop(of: [.text], isTargeted: nil, perform: { providers, location in
					print("drop text")
					return false
				})
				
				Button {
					logicBackend.flagPressedTrigger()
				} label: {
					ZStack {
						Circle()
							.strokeBorder(Color.green, lineWidth: 4)
							.background(Circle().foregroundColor(Color.green.opacity(0.1)))
							.frame(width: 72, height: 72)
						
						VStack {
							Image(systemName: "flag.fill")
								.foregroundColor(logicBackend.programs.isEmpty ? .gray : .green)
								.frame(alignment: .bottomTrailing)
								.font(.title.bold())
							
							Text("Go")
								.foregroundColor(.black)
								.font(.title3.italic())
						}
					}
				}
				.position(x: geometry.size.width - 50, y: geometry.size.height - 50)
			}
			.background(Color.white)
		}
	}
}

struct LogicDetailView_Previews: PreviewProvider {
	static var previews: some View {
		let board = Board.mockBoard1
		let boardDocument =  BoardDocument(board: board)
		let backend = LogicToBoardInterface(board: boardDocument)
		
		LogicBuilderView()
			.environmentObject(backend)
	}
}

