//
//  Motion.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

fileprivate let motionColour = Color(r: 0x69, g: 0x96, b: 0xf9)

struct MoveSteps: View {
    var body: some View {
		InOutBlock(shapeColour: motionColour) {
			HStack {
				Text("move")
				VariablePlaceholder(borderColor: motionColour) { Text("10") }
				Text("steps")
			}
		}
    }
}

struct TurnClockwise: View {
	var body: some View {
		InOutBlock(shapeColour: motionColour) {
			HStack {
				Text("turn")
				Image(systemName: "arrow.clockwise")
					.rotationEffect(Angle(degrees: 45))
				VariablePlaceholder(borderColor: motionColour)
				Text("degrees")
			}
		}
	}
}

struct TurnAnticlockwise: View {
	var body: some View {
		InOutBlock(shapeColour: motionColour) {
			HStack {
				Text("turn")
				Image(systemName: "arrow.counterclockwise")
					.rotationEffect(Angle(degrees: -45))
				VariablePlaceholder(borderColor: motionColour)
				Text("degrees")
			}
		}
	}
}

struct Glide: View {
	var body: some View {
		InOutBlock(shapeColour: motionColour) {
			HStack {
				Text("glide")
				VariablePlaceholder(borderColor: motionColour)
				Text("secs to x:")
				VariablePlaceholder(borderColor: motionColour)
				Text("y:")
				VariablePlaceholder(borderColor: motionColour)
			}
		}
	}
}

struct ChangeX: View {
	var body: some View {
		InOutBlock(shapeColour: motionColour) {
			HStack {
				Text("change x by")
				VariablePlaceholder(borderColor: motionColour)
			}
		}
	}
}

struct SetX: View {
	var body: some View {
		InOutBlock(shapeColour: motionColour) {
			HStack {
				Text("set x to")
				VariablePlaceholder(borderColor: motionColour)
			}
		}
	}
}

struct SetY: View {
	var body: some View {
		InOutBlock(shapeColour: motionColour) {
			HStack {
				Text("set x to")
				VariablePlaceholder(borderColor: motionColour)
			}
		}
	}
}

struct ChangeY: View {
	var body: some View {
		InOutBlock(shapeColour: motionColour) {
			HStack {
				Text("change y by")
				VariablePlaceholder(borderColor: motionColour)
			}
		}
	}
}

struct XPosition: View {
	var body: some View {
		VariableBlock(shapeColor: motionColour) {
			Text("x position")
		}
	}
}

struct YPosition: View {
	var body: some View {
		VariableBlock(shapeColor: motionColour) {
			Text("y position")
		}
	}
}

struct Motion_Previews: PreviewProvider {
    static var previews: some View {
		VStack(alignment: .leading) {
			MoveSteps()
			TurnClockwise()
			TurnAnticlockwise()
			Glide()
			ChangeX()
			SetX()
			ChangeY()
			SetY()
			XPosition()
			YPosition()
		}
    }
}
