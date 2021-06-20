//
//  EdgeInsets+VerticalHorizontal.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 20/06/2021.
//

import SwiftUI

extension EdgeInsets {
	init(vertical: CGFloat, horizontal: CGFloat) {
		self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
	}
}
