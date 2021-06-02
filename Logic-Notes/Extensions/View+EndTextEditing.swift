//
//  View+EndTextEditing.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 01/06/2021.
//

import SwiftUI

extension View {
	func endTextEditing() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
										to: nil, from: nil, for: nil)
	}
	
	/*
	USAGE:
	
	// Parent view contains child view
	parentView()
		.onTapGesture {
			self.endTextEditing()
		}
	
	*/
}

