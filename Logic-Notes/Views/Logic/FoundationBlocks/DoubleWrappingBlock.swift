//
//  DoubleWrappingBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 13/06/2021.
//

import SwiftUI

struct DoubleWrappingBlock<Content: View>: View {
	
	let shapeColour: Color
	let block = DoubleWrappingBlockShape()
	@ViewBuilder var topContent: () -> Content
	@ViewBuilder var midContent: () -> Content
	
	var body: some View {
		GeometryReader { geometry in
			ZStack(alignment: .leading) {
				block
					.overlay(
						block
							.stroke(shapeColour, lineWidth: 1)
							.brightness(-0.15)
					).foregroundColor(shapeColour)
				
				topContent()
					.padding(4)
					.foregroundColor(.white)
					.font(.title2.bold())
					.frame(maxWidth: .infinity, alignment: .leading)
					.position(x: geometry.size.width / 2, y: block.topOffset / 2)
				
				midContent()
					.padding(4)
					.foregroundColor(.white)
					.font(.title2.bold())
					.frame(maxWidth: .infinity, alignment: .leading)
					.position(x: geometry.size.width / 2, y: block.topOffset + block.upperGapHeight + block.topOffset/2)
			}
		}
		.frame(minWidth: 100, minHeight: 230, alignment: .leading)
		.fixedSize()
	}
}

struct DoubleWrappingBlock_Previews: PreviewProvider {
	static var previews: some View {
		DoubleWrappingBlock(shapeColour: .blue) {
			Text("if true then")
		} midContent: {
			Text("else do this")
		}
	}
}
