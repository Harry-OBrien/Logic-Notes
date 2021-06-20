//
//  EndBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

struct EndBlock<Content: View>: View {
	
	let shapeColour: Color
	@ViewBuilder var content: () -> Content
	
	var body: some View {
		BaseBlock(shapeColour: shapeColour, block: EndBlockShape(), content: content)
	}
}

//struct EndBlock_Previews: PreviewProvider {
//    static var previews: some View {
//		EndBlock(Sh) {
//			Text("Finish")
//		}
//    }
//}
