//
//  LogicBuilder.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 07/06/2021.
//

import SwiftUI

struct LogicBuilder: View {
	@EnvironmentObject var document: BoardDocument
	@State var showMenu = true
	
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
					LogicDetailView(showMenu: $showMenu)
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
		return 3*geometry.size.width/4
	}
}

struct LogicDetailView: View {
	
	@Binding var showMenu: Bool
	
	var body: some View {
		Text("Drag logic blocks here to build something awesome!")
	}
}

struct ComponentListView: View {
	
	var body: some View {
		List {
			Section(header: Text("Logic Blocks").font(.title.bold())) {}
			
			Section(header: Text("Motion")) {
				MoveSteps()
				TurnClockwise()
				TurnAnticlockwise()
				Glide()
				ChangeX()
				SetX()
				ChangeY()
				SetY()
				XPosition()
				YPosition()
			}
			
			Section(header: Text("Looks")) {
				Say("Hello world!")
				Think("Hmm...")
				ChangeSize(10)
				SetSize(100)
				ShowBlock()
				HideBlock()
				SizeBlock()
			}
			
			Section(header: Text("Sounds & Notifications")) {
				PlaySound()
			}
			
			
			Section(header: Text("Events")) {
				FlagPressed()
				SpritePressed()
				BroadcastReceive()
				BroadcastSend()
				BroadcastSendAndWait()
			}
			
			Section(header: Text("Control")) {
				RepeatForever()
				IfElse()
				EndAll()
			}
			
			
			Section(header: Text("Operators")) {
				
			}
			
			Section(header: Text("Variables")) {
				
			}
		}
		.frame(maxWidth: .infinity, alignment: .top)
		.edgesIgnoringSafeArea(.all)
	}
}

struct LogicBuilder_Previews: PreviewProvider {
	static var previews: some View {
		let document = BoardDocument(board: Board.getMockBoard2())
		
		LogicBuilder()
			.environmentObject(document)
	}
}
