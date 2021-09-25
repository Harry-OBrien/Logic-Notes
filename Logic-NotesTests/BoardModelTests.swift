//
//  BoardModelTests.swift
//  Logic-NotesTests
//
//  Created by Harry O'Brien on 23/09/2021.
//

import XCTest
@testable import Logic_Notes

class BoardModelTests: XCTestCase {
	private let jsonFileName = "TestBoardJSON"
	private var mockJSONData: Data!
	
	private let boardTitle = "Test Board"
	private let collectionTitle = "Test collection"
	private let collectionPosition = (64, 512)
	private let collectionLocked = true
	private let noteContent = "note 1"
	
	private let programID = UUID(uuidString: "BF7CD6FF-7321-4D70-BC13-51C211DEE30D")
	private let blockID1 = UUID(uuidString: "82A020FD-874D-4316-BC89-14465890D42C")
	private let blockID2 = UUID(uuidString: "68700059-FFAD-4155-BEAB-CD523983008C")
	private let blockID3 = UUID(uuidString: "D1884009-2EB6-43E4-94CB-5A58C08FBEAE")
	private let blockID4 = UUID(uuidString: "1EE3AC82-A3F7-413E-8C28-342AA0A6FF40")
	
	override func setUpWithError() throws {
		try super.setUpWithError()
		
		if let url = Bundle.main.url(forResource: jsonFileName, withExtension: ".json") {
			self.mockJSONData = try Data(contentsOf: url)
		}
		else {
			XCTFail("JSON file not loaded correctly")
		}
	}
	
	// Decode test from JSON
	func test_decode_board_from_JSON() throws {
		let board = try JSONDecoder().decode(Board.self, from: mockJSONData)
		validateExpectedValues(for: board)
	}
	
	// Encoding test to JSON
	func test_encode_board_to_JSON() throws {
		// Create the board
		var board = Board(title: boardTitle)
		
		try! board.createCollection(id: collectionTitle,
								 locked: collectionLocked,
								 x: collectionPosition.0,
								 y: collectionPosition.1)
		
		board.collections[collectionTitle]!.addNote(content: noteContent)
		
		// Add the program
		let program = Program(
			id: programID,
			code: [
				FlagPressedLogicBlock(id: blockID1),
				SetXLogicBlock(id: blockID2, referencedCollection: collectionTitle, xVal: 32),
				SetYLogicBlock(id: blockID3, referencedCollection: nil, yVal: 128),
				SayLogicBlock(id: blockID4, content: "Test program complete!")
			],
			trigger: .flagPressed)
		board.associatedPrograms = [program]
		
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		
		let encodedJSON = try encoder.encode(board)
		print(NSString(data: encodedJSON, encoding: String.Encoding.utf8.rawValue)!)
		
		let decodedResult = try JSONDecoder().decode(Board.self, from: encodedJSON)
		validateExpectedValues(for: decodedResult)
	}
	
	fileprivate func validateExpectedValues(for board: Board) {
		XCTAssertEqual(board.title, boardTitle)
		XCTAssertEqual(board.collections[collectionTitle]!.id, collectionTitle)
		XCTAssertEqual(board.collections[collectionTitle]!.x, collectionPosition.0)
		XCTAssertEqual(board.collections[collectionTitle]!.y, collectionPosition.1)
		XCTAssertEqual(board.collections[collectionTitle]!.locked, collectionLocked)
		XCTAssertEqual(board.collections[collectionTitle]!.notes[0].text, noteContent)
		
		// test to see if program has all the correct components
		let program = board.associatedPrograms[0]
		
		XCTAssertEqual(program.id, programID)
		
		let flagPressedBlock = program.code[0] as! FlagPressedLogicBlock
		XCTAssertEqual(flagPressedBlock.id, blockID1)
		XCTAssertEqual(flagPressedBlock.type, .FlagPressed)
		
		let setXBlock = program.code[1] as! SetXLogicBlock
		XCTAssertEqual(setXBlock.id, blockID2)
		XCTAssertEqual(setXBlock.type, .SetX)
		XCTAssertEqual(setXBlock.referencedCollection, collectionTitle)
		XCTAssertEqual(setXBlock.xVal, 32)
		
		let setYBlock = program.code[2] as! SetYLogicBlock
		XCTAssertEqual(setYBlock.id, blockID3)
		XCTAssertEqual(setYBlock.type, .SetY)
		XCTAssertEqual(setYBlock.referencedCollection, nil)
		XCTAssertEqual(setYBlock.yVal, 128)
	}
}
