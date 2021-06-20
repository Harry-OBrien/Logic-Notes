//
//  Color+rgb.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

extension Color {
	init (r: CGFloat, g: CGFloat, b: CGFloat, opacity: CGFloat = 1) {
		self.init(.sRGB, red: r/255, green: g/255, blue: b/255, opacity: opacity)
	}
}
