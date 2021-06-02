//
//  TriangleShape.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 29/05/2021.
//

import Foundation
import SwiftUI

struct Triangle: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		
		path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
		
		return path
	}
}
