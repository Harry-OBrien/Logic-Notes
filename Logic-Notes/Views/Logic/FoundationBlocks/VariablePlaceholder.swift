//
//  VariablePlaceholder.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 20/06/2021.
//

import SwiftUI

struct VariablePlaceholder<Content: View>: View {
	
	private let borderColor: Color
	@ViewBuilder private var content: () -> Content
	
	init(borderColor: Color, @ViewBuilder content: @escaping () -> Content) {
		self.borderColor = borderColor
		self.content = content
	}
	
	init(borderColor: Color) where Content == EmptyView {
		self.borderColor = borderColor
		self.content = { EmptyView() }
	}
	
	private let block = VariableBlockShape()
	
	var body: some View {
		ZStack(alignment: .center) {
			block
				.overlay(
					block
						.stroke(borderColor, lineWidth: 1)
						.brightness(-0.15)
				).foregroundColor(.white)
			
			content()
				.padding(EdgeInsets(vertical: 4, horizontal: 8))
				.foregroundColor(Color(r: 0x5a, g: 0x5e, b: 0x73))
				.font(.title3.bold())
		}
		.frame(minWidth: 40, minHeight: 35, alignment: .center)
		.fixedSize()
	}
}

struct VariablePlaceholder_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			VariablePlaceholder(borderColor: .blue)
			VariablePlaceholder(borderColor: .blue) { Text("10") }
		}
	}
}
