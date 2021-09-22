//
//  StartBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

struct StartBlock<Content: View>: View {
	
	let shapeColour: Color
	@ViewBuilder var content: Content
	
	private let block = StartBlockShape()
	
	init(shapeColour: Color, content: () -> Content) {
		self.shapeColour = shapeColour
		self.content = content()
	}
	
	var body: some View {
		ZStack(alignment: .leading) {
			block
				.overlay(
					block
						.stroke(shapeColour, lineWidth: 1)
						.brightness(-0.15)
				)
				.foregroundColor(shapeColour)
			
			content
				.padding(EdgeInsets(vertical: 4, horizontal: 10))
				.foregroundColor(.white)
				.font(.title2.bold())
		}
		.frame(minWidth: 130, minHeight: 80, alignment: .leading)
		.fixedSize()
	}
}

struct StartBlock_Previews: PreviewProvider {
	static var previews: some View {
		StartBlock(shapeColour: .blue) {
			Text("When 'this bitch' empty")
		}
	}
}
