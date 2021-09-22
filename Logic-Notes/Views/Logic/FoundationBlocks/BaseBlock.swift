//
//  BaseBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

struct BaseBlock<Content: View, Block: LogicBlockShape>: View {
	
	let shapeColour: Color
	let block: Block
	@ViewBuilder var content: () -> Content
	
	var body: some View {
		ZStack(alignment: .leading) {
			block
				.overlay(
					block
						.stroke(shapeColour, lineWidth: 1)
						.brightness(-0.15)
				)
				.foregroundColor(shapeColour)
			
			content()
				.offset(y: -block.notchRect.height/2)
				.padding(EdgeInsets(vertical: 4, horizontal: 10))
				.foregroundColor(.white)
				.font(.title2.bold())
		}
		.frame(minWidth: 80, minHeight: 70, alignment: .leading)
		.fixedSize()
	}
}
