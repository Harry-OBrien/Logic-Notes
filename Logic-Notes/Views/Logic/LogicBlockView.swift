//
//  LogicBlockView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 24/09/2021.
//

import SwiftUI

func viewFor(_ logicBlock: LogicBlock, in program: Program?, boardDocument: BoardDocument) -> some View {
	Group {
		switch(logicBlock.type) {
				// Motion
			case .SetX:
				var block = logicBlock as! SetXLogicBlock
				SetX(for: boardDocument.collectionIDs, to: block.xVal, targetCollectionDidChange: { collectionID in
					if let program = program {
						block.referencedCollection = collectionID
						boardDocument.update(logicBlock: block as LogicBlock, in: program)
					}
				})
				
			case .SetY:
				let block = logicBlock as! SetYLogicBlock
				SetY(for: boardDocument.collectionIDs, to: block.yVal)
				
			case .XPos:
				XPosition()
				
			case .YPos:
				YPosition()
				
				// Looks
			case .Say:
				let sayBlock = logicBlock as! SayLogicBlock
				Say(sayBlock.content)
				
				// Sound
				// ...
				
				// Events
			case .FlagPressed:
				FlagPressed()
				
				// Control
				
				// Operators
			case .End:
				End()
				
			default:
				Say("Not Implemented")
		}
	}
}
