//
//  ProgramView.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 13/07/2021.
//

import SwiftUI

struct ProgramView: View {
	
	let program: Program
	@EnvironmentObject private var logicBackend: LogicToBoardInterface
	
	var body: some View {
		VStack(alignment: .leading, spacing: -10) {
//			ForEach(program.code) { block in
//				viewFor(block)
//			}
		}
	}
	
	private func viewFor(_ logicBlock: LogicBlock) -> some View {
		Group {
			switch(logicBlock.type) {
					// Motion
				case .SetX:
					let block = logicBlock as! SetXLogicBlock
					SetX(for: logicBackend.collectionIDs, to: block.xVal, targetCollectionDidChange: { collectionID in
//						logicBackend.targetCollectionChanged(for: logicBlock, to: collectionID)
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
}


//struct ProgramView_Previews: PreviewProvider {
//	static var previews: some View {
//		ProgramView(program: Program.mockProgram)
//	}
//}
