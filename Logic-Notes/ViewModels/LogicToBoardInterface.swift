//
//  LogicBuilderBackEnd.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 11/07/2021.
//

import SwiftUI

class LogicToBoardInterface: ObservableObject {
	
	var board: BoardDocument

	var programs: [Program] {
		board.associatedPrograms
	}
	
	init(board: BoardDocument) {
		self.board = board
	}
	
	var collectionIDs: [String] {
		board.collections.map {$0.id}
	}
	
	func targetCollectionChanged(for logicBlock: inout LogicBlock, to newCollectionID: CollectionID) {
		logicBlock.referencedCollection = newCollectionID
	}
	
	// MARK: - Program Triggers
	func flagPressedTrigger() {
		print("Flag pressed!")
		
		// For every program
		for program in programs {
			// If program is activated by the flag press
			if case .flagPressed = program.trigger {
				// Execute all of the code blocks in order
				for codeBlock in program.code {
					codeBlock.execute()
				}
			}
		}
	}
}
