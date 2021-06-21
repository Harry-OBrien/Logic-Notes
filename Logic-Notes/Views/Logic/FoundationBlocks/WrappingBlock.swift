//
//  WrappingBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 13/06/2021.
//

import SwiftUI

struct WrappingBlock<Content: View>: View {
	
	let shapeColour: Color
	let block = WrappingBlockShape()
	@ViewBuilder var content: () -> Content
	
	var body: some View {
		GeometryReader { geometry in
			ZStack(alignment: .leading) {
				block
					.overlay(
						block
							.stroke(shapeColour, lineWidth: 1)
							.brightness(-0.15)
					).foregroundColor(shapeColour)
				
				content()
					.padding(4)
					.foregroundColor(.white)
					.font(.title2.bold())
					.frame(maxWidth: .infinity, alignment: .leading)
					.position(x: geometry.size.width / 2, y: block.topOffset / 2)
			}
		}
		.frame(minWidth: 100, minHeight: 3 * block.topOffset, alignment: .leading)
		.fixedSize()
	}
}
struct WrappingBlock_Previews: PreviewProvider {
	static var previews: some View {
		WrappingBlock(shapeColour: .blue) {
			Text("if we want")
		}
	}
}
