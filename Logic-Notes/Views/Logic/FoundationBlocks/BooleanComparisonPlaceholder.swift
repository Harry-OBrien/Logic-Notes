//
//  BooleanComparisonPlaceholder.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 20/06/2021.
//

import SwiftUI


struct BooleanComparisonPlaceholder: View {
	
	let shapeColor: Color

	let block = BooleanComparisonBlockShape()
	
	var body: some View {
		ZStack(alignment: .center) {
			block
				.foregroundColor(shapeColor)
				.brightness(-0.15)
		}
		.frame(minWidth: 65, minHeight: 45, alignment: .center)
		.fixedSize()
	}
}

