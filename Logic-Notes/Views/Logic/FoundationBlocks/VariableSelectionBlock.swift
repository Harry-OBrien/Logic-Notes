//
//  VariableSelectionBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 20/06/2021.
//

import SwiftUI

struct VariableSelectionBlock: View {
	
	private let shapeColor: Color
	private let borderColor: Color
	@Binding private var activeIndex: Int
	private let selection: [String]
	
	@State private var showVariableOptions = false
	
	init(shapeColor: Color, borderColor: Color? = nil, activeIndex: Binding<Int>, selection: [String]) {
		self.shapeColor = shapeColor
		self.borderColor = borderColor ?? shapeColor
		self._activeIndex = activeIndex
		self.selection = selection
	}
	
	private let block = VariableBlockShape()
	
	var body: some View {
		ZStack(alignment: .center) {
			block
				.brightness(-0.05)
				.overlay(
					block
						.stroke(borderColor, lineWidth: 1)
						.brightness(-0.15)
				).foregroundColor(shapeColor)
			
			HStack {
				Group {
					if activeIndex >= 0 && activeIndex < selection.count {
						Text(selection[activeIndex])
					}
					else {
						Text("N/A")
					}
				}
				Image(systemName: "triangle.fill")
					.rotationEffect(Angle(degrees: 180))
					.font(.body)
			}
			.foregroundColor(.white)
			.font(.title2.bold())
			.padding(EdgeInsets(vertical: 4, horizontal: 8))
		}
		.frame(minWidth: 50, minHeight: 35, alignment: .center)
		.fixedSize()
		.popover(isPresented: $showVariableOptions, arrowEdge: .top) {
			Group {
				if selection.count > 0 {
					List(selection.indices, id: \.self) { idx in
						Text(selection[idx])
							.foregroundColor(.black)
							.font(.title3)
							.onTapGesture {
								self.activeIndex = idx
								self.showVariableOptions = false
							}
						
					}
				}
				else {
					Button {
						print("New var pressed!")
					} label: {
						HStack {
							Text("new variable")
							Image(systemName: "plus")
						}
						.buttonStyle(.bordered)
					}
				}
			}
			.frame(minWidth: 250, minHeight: 300)
		}
		.onTapGesture {
			showVariableOptions.toggle()
		}
	}
}

//struct VariableSelectionBlock_Previews: PreviewProvider {
//	static var previews: some View {
//		VStack {
//			VariableSelectionBlock(shapeColor: .blue, activeIndex: 0, selection: [])
//			VariableSelectionBlock(shapeColor: .blue, activeIndex: 0, selection: [1, 2, 3].map { "\($0)" })
//			VariableSelectionBlock(shapeColor: .blue, activeIndex: 0, selection: ["a", "b", "c"])
//		}
//	}
//}
