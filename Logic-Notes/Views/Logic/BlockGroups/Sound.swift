//
//  Sound.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 20/06/2021.
//

import SwiftUI

fileprivate let soundColor = Color(r: 0xb7, g: 0x63, b: 0xcb)

/// Plays a sound
struct PlaySound: View {
	@State private var index: Int? = nil
	
    var body: some View {
		InOutBlock(shapeColour: soundColor) {
			HStack {
				Text("play sound")
				VariableSelectionBlock(shapeColor: soundColor,
									   activeIndex: $index,
									   selection: ["Meow", "Whistle", "Bell", "Air Horn"])
				Text("until done")
			}
		}
    }
}

// TODO: Implement notifications/alerts as logic block

struct Sound_Previews: PreviewProvider {
    static var previews: some View {
		PlaySound()
    }
}
