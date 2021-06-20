//
//  StartBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

struct StartBlock<Content: View>: View {
	
	let shapeColour: Color
	@ViewBuilder var content: () -> Content
	
	var body: some View {
		BaseBlock(shapeColour: shapeColour, block: StartBlockShape(), content: content)
	}
}

struct StartBlock_Previews: PreviewProvider {
	static var previews: some View {
		StartBlock(shapeColour: .blue) {
			Text("When 'this bitch' empty")
		}
	}
}
