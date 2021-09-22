//
//  LogicCodeBlock.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 11/06/2021.
//

import Foundation


enum LogicBlockCodingKeys: CodingKey {
	case id, type, referencedCollection, associatedValue
}

// MARK: - Motion
struct SetXLogicBlock: LogicBlock, Identifiable {
	let id: UUID
	let type: LogicBlockType
	var referencedCollection: String?
	var xVal: Int
	
	init(id: UUID? = nil, referencedCollection: String?, xVal: Int) {
		self.id = id ?? UUID()
		
		self.type = .SetX
		self.referencedCollection = referencedCollection
		self.xVal = xVal
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
		self.type = try container.decode(LogicBlockType.self, forKey: .type)
		assert(self.type == .SetX)
		
		self.referencedCollection = try container.decodeIfPresent(String.self, forKey: .referencedCollection)
		self.xVal = try container.decode(Int.self, forKey: .associatedValue)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		// encode all the common values
		try encode(to: &container)
		
		// then our associated value
		try container.encode(xVal, forKey: .associatedValue)
	}
	
	func execute() {
		print("moving \(referencedCollection ?? "N/A") to \(xVal)")
	}
}

struct SetYLogicBlock: LogicBlock, Identifiable {
	let id: UUID
	let type: LogicBlockType
	var referencedCollection: String?
	
	var yVal: Int
	
	init(id: UUID? = nil, referencedCollection: String?, yVal: Int) {
		self.id = id ?? UUID()
		
		self.type = .SetY
		self.referencedCollection = referencedCollection
		self.yVal = yVal
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
		self.type = try container.decode(LogicBlockType.self, forKey: .type)
		assert(self.type == .SetY)
		
		self.referencedCollection = try container.decodeIfPresent(String.self, forKey: .referencedCollection)
		self.yVal = try container.decode(Int.self, forKey: .associatedValue)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		// encode all the common values
		try encode(to: &container)
		
		// then our associated value
		try container.encode(yVal, forKey: .associatedValue)
	}
	
	func execute() {
		print("moving \(referencedCollection ?? "N/A") to \(yVal)")
	}
}

// MARK: - Looks
struct SayLogicBlock: LogicBlock, Identifiable {
	let id: UUID
	let type: LogicBlockType
	var referencedCollection: String?
	
	var content: String
	
	init(id: UUID? = nil, content: String) {
		self.id = id ?? UUID()
		
		self.type = .Say
		self.content = content
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
		self.type = try container.decode(LogicBlockType.self, forKey: .type)
		assert(self.type == .Say)
		
		self.referencedCollection = try container.decodeIfPresent(String.self, forKey: .referencedCollection)
		self.content = try container.decode(String.self, forKey: .associatedValue)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		// encode all the common values
		try encode(to: &container)
		
		// then our associated value
		try container.encode(content, forKey: .associatedValue)
	}
	
	func execute() {
		print(content)
	}
}

// MARK: - Sound
// ...

// MARK: - Events
struct FlagPressedLogicBlock: LogicBlock, Identifiable {
	let id: UUID
	let type: LogicBlockType
	var referencedCollection: String?
	
	init(id: UUID? = nil) {
		self.id = id ?? UUID()
		
		self.type = .FlagPressed
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		// Decode values
		self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
		self.type = try container.decode(LogicBlockType.self, forKey: .type)
		assert(self.type == .FlagPressed)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		// encode all the common values
		try encode(to: &container)
	}
}

// MARK: - Control

// MARK: - Operators
/*
struct EndCodeBlock: LogicBlock {
	var id: Int
	
	var typeID: LogicBlockType
	
	var referencedCollection: CollectionID?
	
	func execute() {
		print("Code end")
	}
	
	init(id: Int) {
		self.id = id
		self.typeID = .End
		self.referencedCollection = nil
	}
}
*/
