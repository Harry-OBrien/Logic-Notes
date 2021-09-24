//
//  VariableSelectionBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 20/06/2021.
//

import SwiftUI

struct VariableSelectionBlock: View {
	
	private let shapeColor: Color
	private let borderColor: Color
	@Binding private var activeIndex: Int?
	private let options: [String]
	
	@State private var showVariableOptions = false
	
	init(shapeColor: Color, borderColor: Color? = nil, activeIndex: Binding<Int?>, values: [String]) {
		self.shapeColor = shapeColor
		self.borderColor = borderColor ?? shapeColor
		self._activeIndex = activeIndex
		self.options = values
		
		// Check index is in range
		if let index = self.activeIndex, index >= values.count || index < 0 {
			self.activeIndex = nil
		}
	}
	
	private let block = VariableBlockShape()
	
	private var selectedOption: String? {
		if options.isEmpty || activeIndex == nil {
			return nil
		}
		
		return options[activeIndex!]
	}
	
	var body: some View {
		ZStack(alignment: .center) {
			block
				.brightness(-0.05)
				.overlay(
					block
						.stroke(borderColor, lineWidth: 1)
						.brightness(-0.15)
				).foregroundColor(shapeColor)
			
			HStack {
				if !options.isEmpty {
					Text(selectedOption ?? "Select")
						.foregroundColor(Color(white: activeIndex != nil ? 1 : 0.85))
					Image(systemName: "triangle.fill")
						.rotationEffect(Angle(degrees: 180))
						.font(.body)
				} else {
					Text("N/A")
						.foregroundColor(Color(white: 0.85))
				}
			}
			.foregroundColor(.white)
			.font(.title2.bold())
			.padding(EdgeInsets(vertical: 4, horizontal: 8))
		}
		.frame(minWidth: 50, minHeight: 35, alignment: .center)
		.fixedSize()
		.onTapGesture {
			if !options.isEmpty {
				showVariableOptions.toggle()
			}
		}
		.popover(isPresented: $showVariableOptions, arrowEdge: .top) {
			// TODO: Fix so we can click the row and not the text
			List(options.indices) { idx in
				Text(options[idx])
					.foregroundColor(.black)
					.font(.title3)
					.onTapGesture {
						self.activeIndex = idx
						self.showVariableOptions = false
					}
			}
			.frame(minWidth: 250, minHeight: 300)
		}
	}
}

struct VariableSelectionBlock_Previews: PreviewProvider {
	@State static var index1: Int? = nil
	@State static var index2: Int? = 2
	@State static var index3: Int? = nil
	
	static var previews: some View {
		VStack {
			VariableSelectionBlock(shapeColor: .blue, activeIndex: $index1, values: [])
			VariableSelectionBlock(shapeColor: .blue, activeIndex: $index2, values: [1, 2, 3].map { "\($0)" })
			VariableSelectionBlock(shapeColor: .blue, activeIndex: $index3, values: ["a", "b", "c"])
		}
	}
}
