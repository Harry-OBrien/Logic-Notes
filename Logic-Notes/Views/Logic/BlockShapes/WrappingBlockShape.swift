//
//  WrappingBlockShape.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 13/06/2021.
//

import SwiftUI

struct WrappingBlockShape: LogicBlockShape {
	
	var leftOffset: CGFloat { notchRect.minX }
	let topOffset: CGFloat = 45
	
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
		
		// Mid Bottom Right
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + topOffset - borderRadius))
		path.addArc(center: CGPoint(x: rect.maxX - borderRadius, y: rect.minY + topOffset - borderRadius),
					radius: borderRadius,
					startAngle: .zero,
					endAngle: Angle(degrees: 90),
					clockwise: false)
		
		// Mid Bottom Notch
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX, y: rect.minY + topOffset))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX - notchTransitionWidth, y: rect.minY + topOffset + notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX + notchTransitionWidth, y: rect.minY + topOffset + notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX, y: rect.minY + topOffset))
		
		// Upper Mid Bottom Left
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + borderRadius, y: rect.minY + topOffset))
		path.addArc(center: CGPoint(x: rect.minX + leftOffset + borderRadius, y:  rect.minY + topOffset + borderRadius),
					radius: borderRadius,
					startAngle: Angle(degrees: 270),
					endAngle: Angle(degrees: 180),
					clockwise: true)
		
		// Lower Mid B
		path.addLine(to: CGPoint(x: rect.minX + leftOffset, y: rect.maxY - topOffset - notchRect.height))
		path.addArc(center: CGPoint(x: rect.minX + leftOffset + borderRadius, y: rect.maxY - topOffset - notchRect.height - borderRadius),
					radius: borderRadius,
					startAngle: Angle(degrees: 180),
					endAngle: Angle(degrees: 90),
					clockwise: true)
		
		// Lower Mid Top Notch
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX, y: rect.maxY - topOffset - notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX + notchTransitionWidth, y: rect.maxY - topOffset))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX - notchTransitionWidth, y: rect.maxY - topOffset))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX, y: rect.maxY - topOffset - notchRect.height))
		
		// Lower Mid Upper Right
		path.addLine(to: CGPoint(x: rect.maxX - borderRadius, y: rect.maxY - topOffset - notchRect.height))
		path.addArc(center: CGPoint(x: rect.maxX - borderRadius, y: rect.maxY - topOffset - notchRect.height + borderRadius),
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

struct WrappingBlockShape_preview: PreviewProvider {
	static var previews: some View {
		WrappingBlockShape()
			.frame(width: 160, height: 180, alignment: .center)
			.foregroundColor(.blue)
	}
}
