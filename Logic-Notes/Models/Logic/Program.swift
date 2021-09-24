//
//  Program.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/07/2021.
//

import Foundation

struct Program: Identifiable {
	let id: UUID
	
	// TODO: Look into type erasure to make logic block identifiable (https://developer.apple.com/forums/thread/130177)
	var code: [LogicBlock]
	let x: Int
	let y: Int
	
	indirect enum Trigger: Codable {
		case flagPressed
		case timeDate(date: Date)
		case message(caller: Program)
	}
	
	var trigger: Trigger
	
	init(id: UUID? = nil, code: [LogicBlock], x: Int = 0, y: Int = 0, trigger: Trigger) {
		self.id = id ?? UUID()
		self.code = code
		self.x = x
		self.y = y
		self.trigger = trigger
	}
}

extension Program: Codable {
	enum CodingKeys: CodingKey {
		case id, code, x, y, trigger
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(UUID.self, forKey: .id)
		self.x = try container.decode(Int.self, forKey: .x)
		self.y = try container.decode(Int.self, forKey: .y)
		self.trigger = try container.decode(Trigger.self, forKey: .trigger)
				
		// decode logic blocks as abstract types
		let abstractCodeCollection = try container.decode([AnyLogicBlock].self, forKey: .code)
		
		self.code = [LogicBlock]()
		
		// Specialise each logic block to its own type
		for block in abstractCodeCollection {
			switch block.type {
				case .SetX:
					self.code.append(block.wrappedBlock as! SetXLogicBlock)
				case .SetY:
					self.code.append(block.wrappedBlock as! SetYLogicBlock)
				case .Say:
					self.code.append(block.wrappedBlock as! SayLogicBlock)
				case .FlagPressed:
					self.code.append(block.wrappedBlock as! FlagPressedLogicBlock)
					
				default:
					let context = DecodingError.Context(
						codingPath: decoder.codingPath,
						debugDescription: "Type \(block.type) currently not implemented for decoding.")
					throw DecodingError.dataCorrupted(context)
			}
		}
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		try container.encode(id, forKey: .id)
		try container.encode(x, forKey: .x)
		try container.encode(y, forKey: .y)
		try container.encode(trigger, forKey: .trigger)
		
		// Create an array in the JSON
		var codeContainer = container.nestedUnkeyedContainer(forKey: .code)
		for block in code {
			switch block.type {
				case .SetX:
					try codeContainer.encode((block as! SetXLogicBlock))
					
				case .SetY:
					try codeContainer.encode((block as! SetYLogicBlock))
					
				case .Say:
					try codeContainer.encode((block as! SayLogicBlock))
					
				case .FlagPressed:
					try codeContainer.encode((block as! FlagPressedLogicBlock))
					
				default:
					let context = EncodingError.Context(
						codingPath: encoder.codingPath,
						debugDescription: "Type \(block.type) currently not implemented for encoding")
					
					throw EncodingError.invalidValue(self, context)
			}
		}
	}
}



/*
extension Program {
	static var mockProgram: Program {
		return Program(code: [FlagPressedLogicBlock(id: 0),
							  SetXLogicBlock(id: 2, newXValue: 32),
							  SetYLogicBlock(id: 3, newYValue: 64),
							  SayLogicBlock(id: 1, content: "Hello world!"),
							  EndCodeBlock(id: 4)
							 ],
					   x: 0,
					   y: 0,
					   trigger: .flagPressed
		)
	}
	
	static var mockPrograms: [Program] {
		[Program(code: [FlagPressedTrigger(id: 0),
						SetXCodeBlock(id: 2, newXValue: 32),
						SetYCodeBlock(id: 3, newYValue: 64),
						SayLogicCodeBlock(id: 1, content: "Hello world!"),
						EndCodeBlock(id: 4)
					   ],
				 x: 0,
				 y: 0,
				 trigger: .flagPressed
				),
		 
		 Program(code: [FlagPressedTrigger(id: 0),
						SayLogicCodeBlock(id: 1, content: "to the right!!"),
						EndCodeBlock(id: 4)
					   ],
				 x: 120,
				 y: 0,
				 trigger: .flagPressed
				),
		 
		 Program(code: [FlagPressedTrigger(id: 0),
						SayLogicCodeBlock(id: 1, content: "Up left please!"),
						EndCodeBlock(id: 4)
					   ],
				 x: -120,
				 y: -400,
				 trigger: .flagPressed
				)
		]
	}
}
*/
