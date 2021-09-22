//
//  WrappingBlockShape.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 13/06/2021.
//

import SwiftUI

struct WrappingBlockShape: LogicBlockShape {
	
	var leftOffset: CGFloat { notchRect.minX }
	var topBarHeight: CGFloat = 50
	var midGapHeight: CGFloat = 30
	let bottomBarHeight: CGFloat = 35
	
	var blockHeight: CGFloat {
		topBarHeight +
		midGapHeight +
		bottomBarHeight
	}
	
	func path(in rect: CGRect) -> Path {
		var path = Path()
		
		let y0 = rect.minY
		let y1 = rect.minY + topBarHeight
		let y2 = rect.minY + topBarHeight + midGapHeight
		let y3 = rect.minY + topBarHeight + midGapHeight + bottomBarHeight
		
		// Start
		path.move(to: CGPoint(x: rect.minX + borderRadius, y: y0))
		
		// Top Notch
		path.addLine(to: CGPoint(x: rect.minX + notchRect.minX, y: y0))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.minX + notchTransitionWidth, y: y0 + notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.maxX - notchTransitionWidth, y: y0 + notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.maxX, y: rect.minY))
		
		// Top Right
		path.addLine(to: CGPoint(x: rect.maxX - borderRadius, y: y0))
		path.addArc(center: CGPoint(x: rect.maxX - borderRadius, y: y0 + borderRadius),
					radius: borderRadius,
					startAngle: Angle(degrees: 270),
					endAngle: .zero,
					clockwise: false)
		
		// Mid Bottom Right
		path.addLine(to: CGPoint(x: rect.maxX, y: y1 - borderRadius))
		path.addArc(center: CGPoint(x: rect.maxX - borderRadius, y: y1 - borderRadius),
					radius: borderRadius,
					startAngle: .zero,
					endAngle: Angle(degrees: 90),
					clockwise: false)
		
		// Mid Bottom Notch
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX, y: y1))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX - notchTransitionWidth, y: y1 + notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX + notchTransitionWidth, y: y1 + notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX, y: y1))
		
		// Upper Mid Bottom Left
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + borderRadius, y: y1))
		path.addArc(center: CGPoint(x: rect.minX + leftOffset + borderRadius, y:  y1 + borderRadius),
					radius: borderRadius,
					startAngle: Angle(degrees: 270),
					endAngle: Angle(degrees: 180),
					clockwise: true)
		
		// Lower Mid B
		path.addLine(to: CGPoint(x: rect.minX + leftOffset, y: y2 - notchRect.height))
		path.addArc(center: CGPoint(x: rect.minX + leftOffset + borderRadius, y: y2 - notchRect.height - borderRadius),
					radius: borderRadius,
					startAngle: Angle(degrees: 180),
					endAngle: Angle(degrees: 90),
					clockwise: true)
		
		// Lower Mid Top Notch
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX, y: y2 - notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX + notchTransitionWidth, y: y2))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX - notchTransitionWidth, y: y2))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX, y: y2 - notchRect.height))
		
		// Lower Mid Upper Right
		path.addLine(to: CGPoint(x: rect.maxX - borderRadius, y: y2 - notchRect.height))
		path.addArc(center: CGPoint(x: rect.maxX - borderRadius, y: y2 - notchRect.height + borderRadius),
					radius: borderRadius,
					startAngle: Angle(degrees: 270),
					endAngle: .zero,
					clockwise: false)
		
		// Bottom Right
		path.addLine(to: CGPoint(x: rect.maxX, y: y3 - borderRadius - notchRect.height))
		path.addArc(center: CGPoint(x: rect.maxX - borderRadius, y: y3 - borderRadius - notchRect.height),
					radius: borderRadius,
					startAngle: .zero,
					endAngle: Angle(degrees: 90),
					clockwise: false)
		
		// Bottom Notch
		path.addLine(to: CGPoint(x: rect.minX + notchRect.maxX, y: y3 - notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.maxX - notchTransitionWidth, y: y3))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.minX + notchTransitionWidth, y: y3))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.minX, y: y3 - notchRect.height))

		// Bottom Left
		path.addLine(to: CGPoint(x: rect.minX + borderRadius, y: y3 - notchRect.height))
		path.addArc(center: CGPoint(x: rect.minX + borderRadius, y: y3 - borderRadius - notchRect.height),
					radius: borderRadius,
					startAngle: Angle(degrees: 90),
					endAngle: Angle(degrees: 180),
					clockwise: false)
		
		// Top Left
		path.addLine(to: CGPoint(x: rect.minX, y: y0 + borderRadius))
		path.addArc(center: CGPoint(x: rect.minX + borderRadius, y: y0 + borderRadius),
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
