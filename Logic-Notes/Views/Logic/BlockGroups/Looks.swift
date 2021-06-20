//
//  Looks.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 20/06/2021.
//

import SwiftUI

fileprivate let looksColor = Color(r: 0x8b, g: 0x66, b: 0xf8)

struct Say: View {
	var textToSay: String
	
	init(_ content: String) {
		self.textToSay = content
	}
	
	var body: some View {
		InOutBlock(shapeColour: looksColor) {
			HStack {
				Text("say")
				VariablePlaceholder(borderColor: looksColor) { Text(textToSay) }
			}
		}
	}
}

struct Think: View {
	var textToThink: String
	
	init(_ content: String) {
		self.textToThink = content
	}
	
	var body: some View {
		InOutBlock(shapeColour: looksColor) {
			HStack {
				Text("think")
				VariablePlaceholder(borderColor: looksColor) { Text(textToThink) }
			}
		}
	}
}

struct ChangeSize: View {
	var sizeChange: Int
	
	init(_ sizeChange: Int) {
		self.sizeChange = sizeChange
	}
	
	var body: some View {
		InOutBlock(shapeColour: looksColor) {
			HStack {
				Text("change size by")
				VariablePlaceholder(borderColor: looksColor) { Text("\(sizeChange)") }
			}
		}
	}
}

struct SetSize: View {
	var newSize: Int
	
	init(_ newSize: Int) {
		self.newSize = newSize
	}
	
	var body: some View {
		InOutBlock(shapeColour: looksColor) {
			HStack {
				Text("set size to")
				VariablePlaceholder(borderColor: looksColor) { Text("\(newSize)") }
				Text("%")
			}
		}
	}
}

struct ShowBlock: View {
	var body: some View {
		InOutBlock(shapeColour: looksColor) {
			Text("show")
		}
	}
}

struct HideBlock: View {
	var body: some View {
		InOutBlock(shapeColour: looksColor) {
			Text("hide")
		}
	}
}

struct SizeBlock: View {
	var body: some View {
		VariableBlock(shapeColor: looksColor) {
			Text("size")
		}
	}
}


struct Looks_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			Say("Hello world!")
			Think("Hmm...")
			ChangeSize(10)
			SetSize(100)
			ShowBlock()
			HideBlock()
			SizeBlock()
		}
    }
}
