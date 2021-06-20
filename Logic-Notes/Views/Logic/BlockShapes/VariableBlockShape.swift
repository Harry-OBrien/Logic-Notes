//
//  VariableBlockShape.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/06/2021.
//

import SwiftUI

struct VariableBlockShape: LogicBlockShape {
	func path(in rect: CGRect) -> Path {
		Path { path in
			
			let w = rect.width
			let h = rect.height
			
			// Make sure we do not exceed the size of the rectangle
			let borderRadius = min(w/2, h/2)
			
			path.move(to: CGPoint(x: borderRadius, y: 0))
			path.addLine(to: CGPoint(x: w - borderRadius, y: 0))
			path.addArc(center: CGPoint(x: w - borderRadius, y: borderRadius),
						radius: borderRadius,
						startAngle: Angle(degrees: -90),
						endAngle: Angle(degrees: 0),
						clockwise: false)
			
			path.addLine(to: CGPoint(x: w, y: h - borderRadius))
			path.addArc(center: CGPoint(x: w - borderRadius, y: h - borderRadius),
						radius: borderRadius,
						startAngle: Angle(degrees: 0),
						endAngle: Angle(degrees: 90),
						clockwise: false)
			
			path.addLine(to: CGPoint(x: borderRadius, y: h))
			path.addArc(center: CGPoint(x: borderRadius, y: h - borderRadius),
						radius: borderRadius,
						startAngle: Angle(degrees: 90),
						endAngle: Angle(degrees: 180),
						clockwise: false)
			
			path.addLine(to: CGPoint(x: 0, y: borderRadius))
			path.addArc(center: CGPoint(x: borderRadius, y: borderRadius), radius: borderRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
		}
	}
}


struct VariableBlockShape_preview: PreviewProvider {
	static var previews: some View {
		VariableBlockShape()
			.frame(width: 160, height: 60, alignment: .center)
			.foregroundColor(.blue)
	}
}
