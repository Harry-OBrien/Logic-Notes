//
//  InOutLogicBlockShape.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

struct InOutLogicBlockShape: LogicBlockShape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		
		// Start
		path.move(to: CGPoint(x: rect.minX + borderRadius, y: rect.minY))
		
		// Top Notch
		path.addLine(to: CGPoint(x: rect.minX + notchRect.minX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.minX + notchTransitionWidth, y: rect.minY + notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.maxX - notchTransitionWidth, y: rect.minY + notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.maxX, y: rect.minY))
		
		// Top Right
		path.addLine(to: CGPoint(x: rect.maxX - borderRadius, y: rect.minY))
		path.addArc(center: CGPoint(x: rect.maxX - borderRadius, y: rect.minY + borderRadius),
					radius: borderRadius,
					startAngle: Angle(degrees: 270),
					endAngle: .zero,
					clockwise: false)
		
		// Bottom Right
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - borderRadius - notchRect.height))
		path.addArc(center: CGPoint(x: rect.maxX - borderRadius, y: rect.maxY - borderRadius - notchRect.height),
					radius: borderRadius,
					startAngle: .zero,
					endAngle: Angle(degrees: 90),
					clockwise: false)
		
		// Bottom Notch
		path.addLine(to: CGPoint(x: rect.minX + notchRect.maxX, y: rect.maxY - notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.maxX - notchTransitionWidth, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.minX + notchTransitionWidth, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.minX, y: rect.maxY - notchRect.height))
		
		// Bottom Left
		path.addLine(to: CGPoint(x: rect.minX + borderRadius, y: rect.maxY - notchRect.height))
		path.addArc(center: CGPoint(x: rect.minX + borderRadius, y: rect.maxY - borderRadius - notchRect.height),
					radius: borderRadius,
					startAngle: Angle(degrees: 90),
					endAngle: Angle(degrees: 180),
					clockwise: false)
		
		// Top Left
		path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + borderRadius))
		path.addArc(center: CGPoint(x: rect.minX + borderRadius, y: rect.minY + borderRadius),
					radius: borderRadius,
					startAngle: Angle(degrees: 180),
					endAngle: Angle(degrees: 270),
					clockwise: false)
		
		return path
	}
}

struct InOutLogicBlockShape_preview: PreviewProvider {
	static var previews: some View {
		InOutLogicBlockShape()
			.frame(width: 120, height: 60, alignment: .center)
			.foregroundColor(.blue)
	}
}
