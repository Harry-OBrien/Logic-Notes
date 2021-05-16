//
//  Note.swift
//  Logic Notes
//
//  Created by Harry O'Brien on 16/05/2021.
//

import Foundation

struct Note: Identifiable, Decodable {
	var id = UUID()
	let content: String
}
