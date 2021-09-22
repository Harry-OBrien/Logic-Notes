//
//  WrappingBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 13/06/2021.
//

import SwiftUI

struct WrappingBlock<Content: View>: View {
	
	private let shapeColour: Color
	private let repeatingCode: Bool
	@ViewBuilder private var content: Content
	
	@State private var block = WrappingBlockShape()
	
	init(shapeColour: Color, repeatingCode: Bool = false, content: () -> Content) {
		self.shapeColour = shapeColour
		self.repeatingCode = repeatingCode
		self.content = content()
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
			
			content
				.offset(y: block.notchRect.height)
				.padding(4)
				.foregroundColor(.white)
				.font(.title2.bold())
				.fixedSize()
			
			Group {
				if repeatingCode {
					HStack {
						Spacer()
						Image(systemName: "arrowshape.turn.up.left.fill")
							.rotationEffect(Angle(degrees: 90))
							.font(.body.bold())
							.foregroundColor(.white)
					}
					.offset(y: block.topBarHeight + block.midGapHeight)
				}
			}
		}
		.frame(minWidth: 100, minHeight: block.blockHeight, alignment: .leading)
		.fixedSize()
	}
}

struct WrappingBlock_Previews: PreviewProvider {
	static var previews: some View {
		WrappingBlock(shapeColour: .blue, repeatingCode: true) {
			HStack {
				Text("repeat while")
				BooleanComparisonPlaceholder(shapeColor: .blue)
			}
		}
//		.border(Color.black)
	}
}
