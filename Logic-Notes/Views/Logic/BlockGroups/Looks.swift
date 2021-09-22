//
//  Looks.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 20/06/2021.
//

import SwiftUI

fileprivate let looksColor = Color(r: 0x8b, g: 0x66, b: 0xf8)

/// Print out a message to console (currently a debugging tool)
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

// TODO: Implement new note creation via logic block

// TODO: Enable ability to hide and show collections
/// Show a collection (no change if not currently hidden)
struct ShowBlock: View {
	var body: some View {
		InOutBlock(shapeColour: looksColor) {
			Text("show")
		}
	}
}

/// Hide a collection (no change if already hidden)
struct HideBlock: View {
	var body: some View {
		InOutBlock(shapeColour: looksColor) {
			Text("hide")
		}
	}
}

struct Looks_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			Say("Hello world!")
			ShowBlock()
			HideBlock()
		}
    }
}
