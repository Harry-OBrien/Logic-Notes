//
//  Note.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation

struct Note: Identifiable, Equatable {
	let id = UUID()
	var content: String
}
