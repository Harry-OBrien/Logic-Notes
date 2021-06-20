//
//  LogicBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

protocol LogicBlockShape: Shape {
	var notchRect: CGRect { get }
	var notchTransitionWidth: CGFloat { get }
	var borderRadius: CGFloat { get }
}

extension LogicBlockShape {
	var notchRect: CGRect { CGRect(x: 16, y: 0, width: 40, height: 10) }
	
	var notchTransitionWidth: CGFloat { 10 }
	
	var borderRadius: CGFloat { 4 }
}
