//
//  Control.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

fileprivate let controlColor = Color(r: 0xff, g: 0xab, b: 0x19)

struct WaitSeconds: View {
	
	var numSeconds: Int
	
	init(_ numSeconds: Int) {
		self.numSeconds = numSeconds
	}
	
	var body: some View {
		InOutBlock(shapeColour: controlColor) {
			HStack {
				Text("wait")
				VariablePlaceholder(borderColor: controlColor) {
					Text("\(numSeconds)")
				}
				Text("seconds")
			}
		}
	}
}

struct RepeatNumTimes: View {
	
	var repeatCount: Int
	
	init(_ repeatCount: Int) {
		self.repeatCount = repeatCount
	}
	
	var body: some View {
		WrappingBlock(shapeColour: controlColor, repeatingCode: true) {
			HStack {
				Text("repeat")
				VariablePlaceholder(borderColor: controlColor) {
					Text("\(repeatCount)")
				}
			}
		}
	}
}

struct RepeatForever: View {
	var body: some View {
		WrappingBlock(shapeColour: controlColor, repeatingCode: true) {
			Text("forever")
		}
	}
}

struct IfCondition: View {
	var body: some View {
		WrappingBlock(shapeColour: controlColor) {
			HStack {
				Text("if")
				BooleanComparisonPlaceholder(shapeColor: controlColor)
				Text("then")
			}
		}
	}
}

struct IfElseCondition: View {
	var body: some View {
		DoubleWrappingBlock(shapeColour: controlColor, topContent: {
			Text("if")
			//			BooleanComparisonPlaceholder(shapeColor: controlColor)
		}, midContent: {
			Text("else")
		})
	}
}


struct WaitUntilCondition: View {
	var body: some View {
		InOutBlock(shapeColour: controlColor) {
			HStack {
				Text("wait until")
				BooleanComparisonPlaceholder(shapeColor: controlColor)
			}
		}
	}
}

struct RepeatUntilCondition: View {
	var body: some View {
		WrappingBlock(shapeColour: controlColor, repeatingCode: true) {
			HStack {
				Text("repeat until")
				BooleanComparisonPlaceholder(shapeColor: controlColor)
			}
		}
	}
}


struct End: View {
	@State private var index: Int? = 1
	
	var body: some View {
		EndBlock(shapeColour: controlColor) {
			HStack {
				Text("stop")
				VariableSelectionBlock(shapeColor: controlColor, activeIndex: $index, values: ["all", "this program"])
			}
		}
	}
}

struct Control_Previews: PreviewProvider {
	static var previews: some View {
		VStack(alignment: .leading) {
			WaitSeconds(10)
			RepeatNumTimes(10)
			RepeatForever()
			IfCondition()
			IfElseCondition()
			WaitUntilCondition()
			RepeatUntilCondition()
			End()
		}
	}
}
