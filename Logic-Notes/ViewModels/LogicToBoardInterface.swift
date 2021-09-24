//
//  LogicBuilderBackEnd.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 11/07/2021.
//

import SwiftUI

class LogicToBoardInterface: ObservableObject {
	
	private var boardDocument: BoardDocument
	
	init(boardDocument: BoardDocument) {
		self.boardDocument = boardDocument
	}
	
	var collectionIDs: [String] {
		boardDocument.collectionIDs
	}

	var programs: [Program] {
		boardDocument.associatedPrograms
	}
	
	func targetCollectionChanged(for logicBlock: LogicBlock, to newCollectionID: CollectionID) {

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
