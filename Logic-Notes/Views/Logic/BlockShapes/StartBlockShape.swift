//
//  StartBlockShape.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

struct StartBlockShape: LogicBlockShape {
	
	private let topArcHeight: CGFloat = 10
	
	func path(in rect: CGRect) -> Path {
		var path = Path()
		
		// Start
		path.move(to: CGPoint(x: rect.minX, y: rect.minY + topArcHeight))
		
		// Top Arc
		path.addArc(in: CGRect(origin: rect.origin, size: CGSize(width: 80, height: topArcHeight)))
		
		// Top Right
		path.addLine(to: CGPoint(x: rect.maxX - borderRadius, y: rect.minY + topArcHeight))
		path.addArc(center: CGPoint(x: rect.maxX - borderRadius, y: rect.minY + borderRadius + topArcHeight),
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
		path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topArcHeight))
		
		return path
	}
}

fileprivate extension Path {
	mutating func addArc(in desiredRect: CGRect) {
		// See www.raywenderlich.com/349664-core-graphics-tutorial-arcs-and-paths for understanding maths
		// limit height to width / 2
		let arcRect = CGRect(origin: desiredRect.origin, size: CGSize(width: desiredRect.width, height: min(desiredRect.height, desiredRect.width / 2)))
		
		let arcRadius = (arcRect.height / 2) + pow(arcRect.width, 2) / (8 * arcRect.height)
		let arcCenter = CGPoint(x: arcRect.origin.x + arcRect.width / 2, y: arcRect.origin.y + arcRadius)
		let angle = acos(arcRect.width / (2 * arcRadius))
		
		let startAngle = Angle(radians: Double.pi + angle)
		let endAngle =  Angle(radians: -angle)
		
		self.addArc(
			center: arcCenter,
			radius: arcRadius,
			startAngle: startAngle,
			endAngle: endAngle,
			clockwise: false)
	}
}

struct StartBlockShape_preview: PreviewProvider {
	static var previews: some View {
		StartBlockShape()
			.frame(width: 120, height: 50, alignment: .center)
			.foregroundColor(.blue)
	}
}
