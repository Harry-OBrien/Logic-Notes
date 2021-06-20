//
//  Logic.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 11/06/2021.
//

import Foundation

protocol LogicBlock: Identifiable, Codable {
	var id: UUID { get set }
	
	var srcCollection: Board.Collection { get set }
	
	var dstCollection: Board.Collection { get set }
		
	func attemptExecution()
}

//struct MoveLogicBlock: LogicBlock {
//	
//	var id: UUID
//	
//	var srcCollection: Board.Collection
//	
//	var dstCollection: Board.Collection
//	
//	init(id: UUID? = nil, src: Board.Collection, dst: Board.Collection) {
//		self.id = id ?? UUID()
//		self.srcCollection = src
//		self.dstCollection = dst
//	}
//	
//	func attemptExecution() {
//		// move notes from src to dst
//	}
//}
