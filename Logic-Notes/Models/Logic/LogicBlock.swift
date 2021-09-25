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
	
	var execute: ((Board.Collection) -> Board.Collection?)

	init(id: UUID? = nil, referencedCollection: String?, xVal: Int) {
		self.id = id ?? UUID()
		
		self.type = .SetX
		self.referencedCollection = referencedCollection
		self.xVal = xVal
		
		self.execute = { [self] collection in
			var newCollection = collection
			newCollection.x = self.xVal
			
			return newCollection
		}
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		let id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
		
		let type = try container.decode(LogicBlockType.self, forKey: .type)
		assert(type == .SetX)
		
		let referencedCollection = try container.decodeIfPresent(String.self, forKey: .referencedCollection)
		let xVal = try container.decode(Int.self, forKey: .associatedValue)
		
		self.init(id: id, referencedCollection: referencedCollection, xVal: xVal)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		// encode all the common values
		try encode(to: &container)
		
		// then our associated value
		try container.encode(xVal, forKey: .associatedValue)
	}
}

struct SetYLogicBlock: LogicBlock, Identifiable {
	let id: UUID
	let type: LogicBlockType
	var referencedCollection: String?
	
	var yVal: Int
	
	var execute: ((Board.Collection) -> Board.Collection?)

	init(id: UUID? = nil, referencedCollection: String?, yVal: Int) {
		self.id = id ?? UUID()
		
		self.type = .SetY
		self.referencedCollection = referencedCollection
		self.yVal = yVal
				
		let execute: ((Board.Collection) -> Board.Collection) = { [self] collection in
			var newCollection = collection
			newCollection.y = self.yVal
			
			return newCollection
		}
		
		self.execute = execute
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		let id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
		let type = try container.decode(LogicBlockType.self, forKey: .type)
		assert(type == .SetY)
		
		let referencedCollection = try container.decodeIfPresent(String.self, forKey: .referencedCollection)
		let yVal = try container.decode(Int.self, forKey: .associatedValue)
		
		self.init(id: id, referencedCollection: referencedCollection, yVal: yVal)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		// encode all the common values
		try encode(to: &container)
		
		// then our associated value
		try container.encode(yVal, forKey: .associatedValue)
	}
}

// MARK: - Looks
struct SayLogicBlock: LogicBlock, Identifiable {
	let id: UUID
	let type: LogicBlockType
	var referencedCollection: String?
	
	var content: String
	
	var execute: ((Board.Collection) -> Board.Collection?)
	
	init(id: UUID? = nil, content: String) {
		self.id = id ?? UUID()
		
		self.type = .Say
		self.content = content
		
		self.execute = { [self] _ in
			print(self.content)
			return nil
		}
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		let id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
		let type = try container.decode(LogicBlockType.self, forKey: .type)
		assert(type == .Say)
		
		let content = try container.decode(String.self, forKey: .associatedValue)
		
		self.init(id: id, content: content)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		// encode all the common values
		try encode(to: &container)
		
		// then our associated value
		try container.encode(content, forKey: .associatedValue)
	}
}

// MARK: - Sound
// ...

// MARK: - Events
struct FlagPressedLogicBlock: LogicBlock, Identifiable {
	let id: UUID
	let type: LogicBlockType
	var referencedCollection: String?
	
	var execute: ((Board.Collection) -> Board.Collection?)

	init(id: UUID? = nil) {
		self.id = id ?? UUID()
		
		self.type = .FlagPressed
		
		self.execute = { _ in return nil }
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: LogicBlockCodingKeys.self)
		
		// Decode values
		let id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
		let type = try container.decode(LogicBlockType.self, forKey: .type)
		assert(type == .FlagPressed)
		
		self.init(id: id)
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
