//
//  CustomAlignment.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 02/06/2021.
//

import SwiftUI

extension HorizontalAlignment {
	enum MyHorizontal: AlignmentID {
		static func defaultValue(in d: ViewDimensions) -> CGFloat
		{ d[HorizontalAlignment.center] }
	}
	static let myAlignment =
		HorizontalAlignment(MyHorizontal.self)
}

extension VerticalAlignment {
	enum MyVertical: AlignmentID {
		static func defaultValue(in d: ViewDimensions) -> CGFloat
		{
			d.height
//			d[VerticalAlignment.center]
			
		}
	}
	static let myAlignment = VerticalAlignment(MyVertical.self)
}

extension Alignment {
	static let myAlignment = Alignment(horizontal: .myAlignment,
									   vertical: .myAlignment)
}
