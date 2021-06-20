//
//  InOutBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

struct InOutBlock<Content: View>: View {
	
	let shapeColour: Color
	@ViewBuilder var content: () -> Content
	
	var body: some View {
		BaseBlock(shapeColour: shapeColour, block: InOutLogicBlockShape(), content: content)
	}
}

struct MotionBlock_Previews: PreviewProvider {
	static var previews: some View {
		let colour = Color(r: 0x69, g: 0x96, b: 0xf9)
		
		return InOutBlock(shapeColour: colour) {
			HStack {
				Text("move")
				VariablePlaceholder(borderColor: colour)
				Text("steps")
			}
		}
	}
}

