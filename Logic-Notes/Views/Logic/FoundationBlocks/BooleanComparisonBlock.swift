//
//  BooleanComparisonBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 20/06/2021.
//

import SwiftUI

struct BooleanComparisonBlock<Content: View>: View {
	
	let shapeColor: Color
	@ViewBuilder var content: () -> Content
	
	init(shapeColor: Color, @ViewBuilder content: @escaping () -> Content) {
		self.shapeColor = shapeColor
		self.content = content
	}
	
	init(shapeColor: Color) where Content == EmptyView {
		self.shapeColor = shapeColor
		self.content = { EmptyView() }
	}
	
	let block = BooleanComparisonBlockShape()
	
	var body: some View {
		ZStack(alignment: .center) {
			block
				.overlay(
					block
						.stroke(shapeColor, lineWidth: 1)
						.brightness(-0.15)
				).foregroundColor(shapeColor)
			
			content()
				.padding(8)
				.foregroundColor(.white)
				.font(.body.bold())
		}
		.frame(minWidth: 80, minHeight: 40, alignment: .center)
		.fixedSize()
	}
}

struct BooleanComparisonBlock_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			BooleanComparisonBlock(shapeColor: .blue) {
				HStack {
					VariablePlaceholder(borderColor: .blue)
						.padding(.leading, 26)
					Text("=")
					VariablePlaceholder(borderColor: .blue)
						.padding(.trailing, 26)
				}
			}
			
			BooleanComparisonBlock(shapeColor: .blue) {
				HStack {
					BooleanComparisonPlaceholder(shapeColor: .blue)
					Text("and")
					BooleanComparisonPlaceholder(shapeColor: .blue)
				}
			}
		}
	}
}
