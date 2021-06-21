//
//  VariableBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 20/06/2021.
//

import SwiftUI

struct VariableBlock<Content>: View where Content: View {
	
	private let shapeColor: Color
	private let borderColor: Color
	@ViewBuilder private var content: () -> Content
	
	init(shapeColor: Color, borderColor: Color? = nil, @ViewBuilder content: @escaping () -> Content) {
		self.shapeColor = shapeColor
		self.borderColor = borderColor ?? shapeColor
		self.content = content
	}
	
	init(shapeColor: Color, borderColor: Color? = nil) where Content == EmptyView {
		self.shapeColor = shapeColor
		self.borderColor = borderColor ?? shapeColor
		self.content = { EmptyView() }
	}
	
	let block = VariableBlockShape()
	
	var body: some View {
		ZStack(alignment: .center) {
			block
				.overlay(
					block
						.stroke(borderColor, lineWidth: 1)
						.brightness(-0.15)
				).foregroundColor(shapeColor)
			
			content()
				.padding(EdgeInsets(vertical: 4, horizontal: 8))
				.foregroundColor(.white)
				.font(.title2.bold())
		}
		.frame(minWidth: 60, minHeight: 50, alignment: .center)
		.fixedSize()
	}
}

struct VariableBlock_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			VariableBlock(shapeColor: .blue) {
				Text("x position")
			}
			
		}
	}
}
