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
			let h = rect.height
			
			// Make sure we do not exceed the size of the rectangle
			let borderRadius = min(w/2, h/2)
			
			path.move(to: CGPoint(x: borderRadius, y: 0))
			path.addLine(to: CGPoint(x: w - borderRadius, y: 0))
			
			path.addLine(to: CGPoint(x: w, y: h/2))
			path.addLine(to: CGPoint(x: w - borderRadius, y: h))
			
			path.addLine(to: CGPoint(x: borderRadius, y: h))
			
			path.addLine(to: CGPoint(x: 0, y: h/2))
			path.addLine(to: CGPoint(x: borderRadius, y: 0))
		}
	}
}

struct BooleanComparisonBlockShape_preview: PreviewProvider {
	static var previews: some View {
		BooleanComparisonBlockShape()
			.frame(width: 160, height: 60, alignment: .center)
			.foregroundColor(.blue)
	}
}
