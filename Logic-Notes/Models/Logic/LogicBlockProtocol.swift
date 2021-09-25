//
//  LogicBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/07/2021.
//

import Foundation

protocol LogicBlock: Codable {
	var id: UUID { get }
	var type: LogicBlockType { get }
	var referencedCollection: CollectionID? { get set }
	
	var execute: ((Board.Collection) -> Board.Collection?) { get }
}

extension LogicBlock {
	func encode(to container: inout KeyedEncodingContainer<LogicBlockCodingKeys>) throws {
		try container.encode(id, forKey: .id)
		try container.encode(type, forKey: .type)
		try container.encodeIfPresent(referencedCollection, forKey: .referencedCollection)
	}
}
