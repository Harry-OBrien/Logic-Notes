//
//  BoardLogicInterfaceTests.swift
//  Logic-NotesTests
//
//  Created by Harry O'Brien on 24/09/2021.
//

import XCTest
@testable import Logic_Notes

class BoardLogicInterfaceTests: XCTestCase {
	private var testBoard: Board!
	private var boardDocument: BoardDocument!
	
	private let collectionID1 = "my collection"
	private let collectionID2 = "collection 2"

    override func setUpWithError() throws {
		try super.setUpWithError()
		
		// Create the board
		testBoard = Board(title: "Test Board")
		try testBoard.createCollection(id: collectionID1, x: 0, y: 0)
		try testBoard.createCollection(id: collectionID2, x: 0, y: 0)
		
		// Create the logic program
		let program = Program(
			code: [
				SetXLogicBlock(referencedCollection: collectionID1, xVal: 48)
			],
			x: 0,
			y: 0,
			trigger: .flagPressed)
		
		testBoard.associatedPrograms = [program]
		
		self.boardDocument = BoardDocument(board: testBoard)
	}

    override func tearDownWithError() throws {
		testBoard = nil
		boardDocument = nil
		
		try super.tearDownWithError()
	}

	func test_target_collection_changed() throws {
		// Get the logic block and check that it is not referencing our target collection
		let program = boardDocument.programs[0]
		var logicBlock = program.code[0]
		XCTAssertNotEqual(logicBlock.referencedCollection, collectionID2)
				
		// Change the target collection
		logicBlock.referencedCollection = collectionID2
		boardDocument.update(logicBlock: logicBlock, in: program)

		// Check if the change was successful
		logicBlock = boardDocument.programs[0].code[0]
		XCTAssertEqual(logicBlock.referencedCollection, collectionID2)
	}
}
