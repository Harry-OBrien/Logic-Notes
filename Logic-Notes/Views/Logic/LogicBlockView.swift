//
//  LogicBlockView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 24/09/2021.
//

import SwiftUI

func viewFor(_ logicBlock: LogicBlock, logicBackend: LogicToBoardInterface) -> some View {
	Group {
		switch(logicBlock.type) {
				// Motion
			case .SetX:
				let block = logicBlock as! SetXLogicBlock
				SetX(for: logicBackend.collectionIDs, to: block.xVal, targetCollectionDidChange: { collectionID in
					logicBackend.targetCollectionChanged(for: logicBlock, to: collectionID)
				})
				
			case .SetY:
				let block = logicBlock as! SetYLogicBlock
				SetY(for: logicBackend.collectionIDs, to: block.yVal)
				
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
