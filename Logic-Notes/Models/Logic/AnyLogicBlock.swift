//
//  AnyLogicBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 21/09/2021.
//

import Foundation

struct AnyLogicBlock: LogicBlock, Codable {
	let id: UUID
	
	let type: LogicBlockType
	
	var referencedCollection: String? = nil
	
	let wrappedBlock: LogicBlock
	
	private enum CodingKeys: CodingKey {
		case type
		case referencedCollection
	}
	
	init(from decoder: Decoder) throws {
		self.id = UUID()
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.type = try container.decode(LogicBlockType.self, forKey: .type)
		
		switch type {
			case .SetX:
				self.wrappedBlock = try SetXLogicBlock(from: decoder)
				
			case .SetY:
				self.wrappedBlock = try SetYLogicBlock(from: decoder)
				
			case .Say:
				self.wrappedBlock = try SayLogicBlock(from: decoder)
				
			case .FlagPressed:
				self.wrappedBlock = try FlagPressedLogicBlock(from: decoder)
				
			default:
				let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid type")
				throw DecodingError.typeMismatch(AnyLogicBlock.self, context)
		}
	}
	
	func encode(to encoder: Encoder) throws {
		// We shouldn't be encoding this to anything
		let context = EncodingError.Context(
			codingPath: encoder.codingPath,
			debugDescription: "The type 'AnyLogicBlock' should not be encoded")
		
		throw EncodingError.invalidValue(self, context)
	}
}
