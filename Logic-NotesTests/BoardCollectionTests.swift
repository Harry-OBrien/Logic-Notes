//
//  BoardCollectionTests.swift
//  Logic-NotesTests
//
//  Created by Harry O'Brien on 14/09/2021.
//

import XCTest
@testable import Logic_Notes

class BoardCollectionTests: XCTestCase {
	
	var testBoard: Board!
	
	override func setUp() {
		super.setUp()
		
		testBoard = Board(title: "Test Board")
	}
	
	override func tearDown() {
		testBoard = nil
		super.tearDown()
	}
	
	// Must be able to add collections to board
	func test_can_add_collection_to_board() throws {
		try testBoard.addCollection(title: "To Do")
	}
	
	// Collections must have unique title
	func test_cannot_add_non_unique_collection() throws {
		let expectedError = Board.Collection.CreationError.notUnique
		var error: Board.Collection.CreationError?
		
		// Add an initial collection (this should not throw)
		try testBoard.addCollection(title: "To Do")
		
		// Create a new collection with the same name and verify we DO throw an error
		XCTAssertThrowsError(try testBoard.addCollection(title: "To Do")) { thrownError in
			error = thrownError as? Board.Collection.CreationError
		}
		
		XCTAssertEqual(error, expectedError)
	}
	
	// We must be able to add notes to a collection
	func test_add_note_to_collection() throws {
		// Create collection
		try testBoard.addCollection(title: "To Do")
		
		// Check no notes currently exist in collection
		XCTAssertEqual(testBoard.collections[0].notes.count, 0)
		
		// Add note to collection
		let noteContent = "Hello world!"
		testBoard.collections[0].addNote(content: noteContent)
		
		// Check we have a single note in the collection
		XCTAssertEqual(testBoard.collections[0].notes.count, 1)
		XCTAssertEqual(testBoard.collections[0].notes[0].text, noteContent)
	}
	
	func test_untitled_collection_yields_unique_name() throws {
		try testBoard.addCollection(title: "Collection 2")
		try testBoard.addCollection(title: "Collection 3")
		try testBoard.addCollection()
				
		XCTAssertNotEqual(testBoard.collections[1].id, testBoard.collections[2].id)
	}
}
