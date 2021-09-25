//
//  LogicBuilderTests.swift
//  Logic-NotesTests
//
//  Created by Harry O'Brien on 20/09/2021.
//

import XCTest
@testable import Logic_Notes

class MoveCollectionLogicTests: XCTestCase {
	
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
				FlagPressedLogicBlock(),
				SetXLogicBlock(referencedCollection: collectionID1, xVal: 48),
				SetYLogicBlock(referencedCollection: collectionID1, yVal: 90),
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
	
	func test_move_collection() {
		XCTAssertEqual(boardDocument.collections[collectionID1]!.x, 0)
		XCTAssertEqual(boardDocument.collections[collectionID1]!.y, 0)
		
		// Execute
		boardDocument.execute(trigger: .flagPressed)
		
		XCTAssertEqual(boardDocument.collections[collectionID1]!.x, 48)
		XCTAssertEqual(boardDocument.collections[collectionID1]!.y, 90)
	}
}
