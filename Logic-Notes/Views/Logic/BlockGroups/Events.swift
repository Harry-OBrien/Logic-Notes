//
//  Events.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

fileprivate let eventColor = Color(r: 0xff, g: 0xbf, b: 0x00)

struct FlagPressed: View {
    var body: some View {
		StartBlock(shapeColour: eventColor) {
			HStack(spacing: 3) {
				Text("when")
				Image(systemName: "flag.fill")
					.foregroundColor(.green)
				Text("pressed")
			}
		}
    }
}

struct SpritePressed: View {
	var body: some View {
		StartBlock(shapeColour: eventColor) {
			Text("when this sprite clicked")
		}
	}
}

struct BroadcastReceive: View {
	@State var index = 0
	var body: some View {
		StartBlock(shapeColour: eventColor) {
			HStack {
				Text("when I receive")
				VariableSelectionBlock(shapeColor: eventColor,
									   activeIndex: $index,
									   selection: ["Message_1", "Message_2", "Message_3"])
			}
		}
	}
}

struct BroadcastSend: View {
	@State var index = 0
	var body: some View {
		InOutBlock(shapeColour: eventColor) {
			HStack {
				Text("send")
				VariableSelectionBlock(shapeColor: eventColor,
									   activeIndex: $index,
									   selection: ["Message_1", "Message_2", "Message_3"])
			}
		}
	}
}

struct BroadcastSendAndWait: View {
	@State var index = 0
	var body: some View {
		InOutBlock(shapeColour: eventColor) {
			HStack {
				Text("send")
				VariableSelectionBlock(shapeColor: eventColor,
									   activeIndex: $index,
									   selection: ["Message_1", "Message_2", "Message_3"])
				Text("and wait")
			}
		}
	}
}

struct Events_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			FlagPressed()
			SpritePressed()
			BroadcastReceive()
			BroadcastSend()
			BroadcastSendAndWait()
		}
    }
}
