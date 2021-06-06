//
//  Hide.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 03/06/2021.
//

import SwiftUI

struct HideModifier: ViewModifier {
	
	var hidden: Bool
	
	func body(content: Content) -> some View {
		Group {
			if hidden { content.hidden() }
			else { content}
		}
	}
}

extension View {
	func Hide(_ hidden: Bool) -> some View {
		self.modifier(HideModifier(hidden: hidden))
	}
}
