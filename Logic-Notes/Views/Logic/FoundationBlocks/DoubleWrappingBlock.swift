//
//  DoubleWrappingBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 13/06/2021.
//

import SwiftUI

struct DoubleWrappingBlock<TopContent: View, MidContent: View>: View {
	
	private let shapeColour: Color
	@ViewBuilder private var topContent: () -> TopContent
	@ViewBuilder private var midContent: () -> MidContent
	
	@State private var block = DoubleWrappingBlockShape()
	
	init(shapeColour: Color,
		 topContent: @escaping () -> TopContent,
		 midContent: @escaping () -> MidContent) {
		self.shapeColour = shapeColour
		self.topContent = topContent
		self.midContent = midContent
	}
	
	var body: some View {
		ZStack(alignment: .topLeading) {
			block
				.overlay(
					block
						.stroke(shapeColour, lineWidth: 1)
						.brightness(-0.15)
				)
				.foregroundColor(shapeColour)
				.onAppear {
					// TODO: Dynamic top bar height
					block.topBarHeight = 55
				}
			
			topContent()
				.offset(y: block.notchRect.height)
				.padding(4)
				.foregroundColor(.white)
				.font(.title2.bold())
			
			midContent()
				.padding(4)
				.foregroundColor(.white)
				.font(.title2.bold())
				.offset(y: block.topBarHeight + block.upperGapHeight + block.notchRect.height/2)
		}
		.frame(minWidth: 100, minHeight: block.blockHeight, alignment: .leading)
		.fixedSize()
	}
}

struct DoubleWrappingBlock_Previews: PreviewProvider {
	static var previews: some View {
		DoubleWrappingBlock(shapeColour: .blue) {
			HStack {
				Text("if")
				BooleanComparisonPlaceholder(shapeColor: .blue)
				Text("then")
			}
		} midContent: {
			Text("else")
		}
	}
}
