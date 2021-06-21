//
//  ConditionalBlockShape.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 20/06/2021.
//

import SwiftUI

struct BooleanComparisonBlockShape: LogicBlockShape {
	func path(in rect: CGRect) -> Path {
		Path { path in
			
			let w = rect.width
			let h = rect.height <= rect.width ? rect.height : rect.width
			
			let top = rect.midY - h/2
			let mid = rect.midY
			let btm = rect.midY + h/2
			
			
			// Make sure we do not exceed the size of the rectangle
			let cornerInset = h/2

			path.move(to: CGPoint(x: cornerInset, y: top))
			path.addLine(to: CGPoint(x: w - cornerInset, y: top))
			
			path.addLine(to: CGPoint(x: w, y: mid))
			path.addLine(to: CGPoint(x: w - cornerInset, y: btm))
			
			path.addLine(to: CGPoint(x: cornerInset, y: btm))
			
			path.addLine(to: CGPoint(x: 0, y: mid))
			path.addLine(to: CGPoint(x: cornerInset, y: top))
		}
	}
}

struct BooleanComparisonBlockShape_preview: PreviewProvider {
	static var previews: some View {
		BooleanComparisonBlockShape()
			.frame(width: 300, height: 100, alignment: .center)
			.foregroundColor(.blue)
	}
}
