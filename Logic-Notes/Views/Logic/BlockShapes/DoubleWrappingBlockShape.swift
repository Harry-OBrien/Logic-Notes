//
//  DoubleWrappingBlockShape.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 13/06/2021.
//

import SwiftUI

struct DoubleWrappingBlockShape: LogicBlockShape {
	
	var leftOffset: CGFloat { notchRect.minX }
	let topOffset: CGFloat = 45
	var upperGapHeight: CGFloat = 45
	var lowerGapHeight: CGFloat = 45
	var bottomBarHeight: CGFloat = 45
	
	func path(in rect: CGRect) -> Path {
		let y0 = rect.minY
		let y1 = rect.minY + topOffset
		let y2 = rect.minY + topOffset + upperGapHeight
		let y3 = rect.minY + topOffset + upperGapHeight + upperGapHeight
		let y4 = rect.maxY - bottomBarHeight
		let y5 = rect.maxY
		
		var path = Path()
		
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
		
		// buhhhh i dunno anymore bro
		path.addLine(to: CGPoint(x: rect.minX + leftOffset, y: y2 - borderRadius))
		path.addArc(center: CGPoint(x: rect.minX + leftOffset + borderRadius, y: y2 - borderRadius),
					radius: borderRadius,
					startAngle: Angle(degrees: 180),
					endAngle: Angle(degrees: 90),
					clockwise: true)
		
		// Upper Mid Top Notch
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX, y: y2))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX + notchTransitionWidth, y: y2 + notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX - notchTransitionWidth, y: y2 + notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX, y: y2))
		
		// Upper Mid Top Right
		path.addLine(to: CGPoint(x: rect.maxX - borderRadius, y: y2))
		path.addArc(center: CGPoint(x: rect.maxX - borderRadius, y: y2 + borderRadius),
					radius: borderRadius,
					startAngle: Angle(degrees: 270),
					endAngle: .zero,
					clockwise: false)
		
		// Upper Mid Bottom Right
		path.addLine(to: CGPoint(x: rect.maxX, y: y3 - borderRadius - notchRect.height))
		path.addArc(center: CGPoint(x: rect.maxX - borderRadius, y: y3 - borderRadius - notchRect.height),
					radius: borderRadius,
					startAngle: .zero,
					endAngle: Angle(degrees: 90),
					clockwise: false)
		
		// upper mid bottom line
		path.addLine(to: CGPoint(x:  rect.minX + leftOffset + notchRect.maxX, y: y3 - notchRect.height))
		
		// Upper mid bottom notch
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX, y: y3 - notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX - notchTransitionWidth, y: y3))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX + notchTransitionWidth, y: y3))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX, y: y3 - notchRect.height))
		
		// upper mid bottom left
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + borderRadius, y: y3 - notchRect.height))
		path.addArc(center: CGPoint(x: rect.minX + leftOffset + borderRadius, y: y3 - notchRect.height + borderRadius),
					radius: borderRadius,
					startAngle: Angle(degrees: 270),
					endAngle: Angle(degrees: 180),
					clockwise: true)
		
		// Lower Mid top left
		path.addLine(to: CGPoint(x: rect.minX + leftOffset, y: y4 - notchRect.height - borderRadius))
		path.addArc(center: CGPoint(x: rect.minX + leftOffset + borderRadius, y: y4 - notchRect.height - borderRadius),
					radius: borderRadius,
					startAngle: Angle(degrees: 180),
					endAngle: Angle(degrees: 90),
					clockwise: true)
		
		// Lower Mid Top Notch
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX, y: y4 - notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.minX + notchTransitionWidth, y: y4))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX - notchTransitionWidth, y: y4))
		path.addLine(to: CGPoint(x: rect.minX + leftOffset + notchRect.maxX, y: y4 - notchRect.height))
		
		// Lower Mid Upper Right
		path.addLine(to: CGPoint(x: rect.maxX - borderRadius, y: y4 - notchRect.height))
		path.addArc(center: CGPoint(x: rect.maxX - borderRadius, y: y4 - notchRect.height + borderRadius),
					radius: borderRadius,
					startAngle: Angle(degrees: 270),
					endAngle: .zero,
					clockwise: false)
		
		// Bottom Right
		path.addLine(to: CGPoint(x: rect.maxX, y: y5 - borderRadius - notchRect.height))
		path.addArc(center: CGPoint(x: rect.maxX - borderRadius, y: y5 - borderRadius - notchRect.height),
					radius: borderRadius,
					startAngle: .zero,
					endAngle: Angle(degrees: 90),
					clockwise: false)
		
		// Bottom Notch
		path.addLine(to: CGPoint(x: rect.minX + notchRect.maxX, y: y5 - notchRect.height))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.maxX - notchTransitionWidth, y: y5))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.minX + notchTransitionWidth, y: y5))
		path.addLine(to: CGPoint(x: rect.minX + notchRect.minX, y: y5 - notchRect.height))
		
		// Bottom Left
		path.addLine(to: CGPoint(x: rect.minX + borderRadius, y: y5 - notchRect.height))
		path.addArc(center: CGPoint(x: rect.minX + borderRadius, y: y5 - borderRadius - notchRect.height),
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

struct DoubleWrappingBlockShape_preview: PreviewProvider {
	static var previews: some View {
		DoubleWrappingBlockShape()
			.frame(width: 160, height: 220, alignment: .center)
			.foregroundColor(.blue)
	}
}
