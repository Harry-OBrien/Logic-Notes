//
//  Control.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

fileprivate let controlColor = Color(r: 0xff, g: 0xab, b: 0x19)

struct RepeatForever: View {
	var body: some View {
		WrappingBlock(shapeColour: controlColor) {
			Text("forever")
		}
	}
}

struct EndAll: View {
    var body: some View {
		EndBlock(shapeColour: controlColor) {
			Text("Stop All")
		}
    }
}

struct IfElse: View {
	var body: some View {
		DoubleWrappingBlock(shapeColour: controlColor) {
			Text("if this")
		} midContent: {
			Text("else")
		}
	}
}

struct Control_Previews: PreviewProvider {
    static var previews: some View {
		VStack(alignment: .leading, spacing: -10) {
			RepeatForever()
			IfElse()
			EndAll()
		}
    }
}
