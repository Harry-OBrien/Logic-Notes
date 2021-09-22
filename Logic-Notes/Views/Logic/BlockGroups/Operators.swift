//
//  Operators.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 22/06/2021.
//

import SwiftUI

fileprivate let operatorColor = Color(r: 0x57, g: 0xb7, b: 0x42)

struct Addition: View {
	var body: some View {
		VariableBlock(shapeColor: operatorColor) {
			HStack {
				VariablePlaceholder(borderColor: operatorColor)
				Text("+")
				VariablePlaceholder(borderColor: operatorColor)
			}
		}
	}
}

struct Subtraction: View {
	var body: some View {
		VariableBlock(shapeColor: operatorColor) {
			HStack {
				VariablePlaceholder(borderColor: operatorColor)
				Text("-")
				VariablePlaceholder(borderColor: operatorColor)
			}
		}
	}
}

struct Multiplication: View {
	var body: some View {
		VariableBlock(shapeColor: operatorColor) {
			HStack {
				VariablePlaceholder(borderColor: operatorColor)
				Text("*")
				VariablePlaceholder(borderColor: operatorColor)
			}
		}
	}
}

struct Division: View {
	var body: some View {
		VariableBlock(shapeColor: operatorColor) {
			HStack {
				VariablePlaceholder(borderColor: operatorColor)
				Text("/")
				VariablePlaceholder(borderColor: operatorColor)
			}
		}
	}
}

struct Random: View {
	
	var randomLow: Int
	var randomHigh: Int
	
	init(from low: Int = 1, to high: Int = 10) {
		self.randomLow = low
		self.randomHigh = high
	}
	
	var body: some View {
		VariableBlock(shapeColor: operatorColor) {
			HStack {
				Text("pick random from")
				VariablePlaceholder(borderColor: operatorColor) {
					Text("\(randomLow)")
				}
				Text("to")
				VariablePlaceholder(borderColor: operatorColor) {
					Text("\(randomHigh)")
				}
			}
		}
	}
}

struct LessThan: View {
	var body: some View {
		BooleanComparisonBlock(shapeColor: operatorColor) {
			HStack {
				VariablePlaceholder(borderColor: operatorColor)
				Text("<")
				VariablePlaceholder(borderColor: operatorColor)
			}
			.padding(EdgeInsets(vertical: 0, horizontal: 14))
		}
	}
}

struct MoreThan: View {
	var body: some View {
		BooleanComparisonBlock(shapeColor: operatorColor) {
			HStack {
				VariablePlaceholder(borderColor: operatorColor)
				Text(">")
				VariablePlaceholder(borderColor: operatorColor)
			}
			.padding(EdgeInsets(vertical: 0, horizontal: 14))
		}
	}
}

struct EqualTo: View {
	var body: some View {
		BooleanComparisonBlock(shapeColor: operatorColor) {
			HStack {
				VariablePlaceholder(borderColor: operatorColor)
				Text("=")
				VariablePlaceholder(borderColor: operatorColor)
			}
			.padding(EdgeInsets(vertical: 0, horizontal: 14))
		}
	}
}

struct BooleanAnd: View {
	var body: some View {
		BooleanComparisonBlock(shapeColor: operatorColor) {
			HStack {
				BooleanComparisonPlaceholder(shapeColor: operatorColor)
				Text("and")
				BooleanComparisonPlaceholder(shapeColor: operatorColor)
			}
		}
	}
}

struct BooleanOr: View {
	var body: some View {
		BooleanComparisonBlock(shapeColor: operatorColor) {
			HStack {
				BooleanComparisonPlaceholder(shapeColor: operatorColor)
				Text("or")
				BooleanComparisonPlaceholder(shapeColor: operatorColor)
			}
		}
	}
}

struct BooleanNot: View {
	var body: some View {
		BooleanComparisonBlock(shapeColor: operatorColor) {
			HStack {
				Text("not")
				BooleanComparisonPlaceholder(shapeColor: operatorColor)
			}
			.padding(.leading, 14)
		}
	}
}

struct Operators_Previews: PreviewProvider {
	static var previews: some View {
		VStack(alignment: .center) {
			Group {
				Addition()
				Subtraction()
				Multiplication()
				Division()
				Random()
			}
			Group {
				LessThan()
				MoreThan()
				EqualTo()
			}
			Group {
				BooleanAnd()
				BooleanOr()
				BooleanNot()
			}
		}
	}
}
