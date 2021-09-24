//
//  MoveCollectionLogicBuilderTests.swift
//  Logic-NotesTests
//
//  Created by Harry O'Brien on 20/09/2021.
//

import XCTest
@testable import Logic_Notes

class MoveCollectionLogicBuilderTests: XCTestCase {
	
	var testBoard: Board!
	
	override func setUpWithError() throws {
		try super.setUpWithError()
		
		// Create the board
		testBoard = Board(title: "Test Board")
		try testBoard.createCollection(id: "my collection", x: 0, y: 0)
		try testBoard.createCollection(id: "collection 2", x: 0, y: 0)
		
		// Create the logic program
		let program = Program(
			code: [
				FlagPressedLogicBlock(),
				SetXLogicBlock(referencedCollection: "my collection", xVal: 48)
			],
			x: 0,
			y: 0,
			trigger: .flagPressed)
		
		testBoard.associatedPrograms = [program]
	}
	
	override func tearDown() {
		testBoard = nil
		super.tearDown()
	}
	
	// When we change the referenced collection on the logic block, the model correctly reflects this change
	func test_target_collection_change_reflected_in_model() throws {
		//
	}
}
