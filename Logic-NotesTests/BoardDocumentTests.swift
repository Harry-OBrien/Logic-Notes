//
//  BoardDocumentTests.swift
//  Logic-NotesTests
//
//  Created by Harry O'Brien on 23/09/2021.
//

import XCTest
@testable import Logic_Notes

class BoardDocumentTests: XCTestCase {
	
	private var docUnderTest: BoardDocument!

    override func setUpWithError() throws {
		try super.setUpWithError()
		
		let testBoard = Board()
		self.docUnderTest = BoardDocument(board: testBoard)
	}

    override func tearDownWithError() throws {
		// Remove the board
		self.docUnderTest = nil
		
		try super.tearDownWithError()
	}

	// MARK: Board geometry
	// We must get the correct bounding box of the board based on the position of the collections
	func test_bounding_box_computed_correctly() throws {
		try docUnderTest.createCollection(titled: "topLeft", at: CGPoint(x: -128, y: -128))
		try docUnderTest.createCollection(titled: "bottomRight", at: CGPoint(x: 128, y: 128))
		
		XCTAssertEqual(docUnderTest.boundingBox, CGRect(x: -128, y: -128, width: 256, height: 256))
	}
	
	// The bounding box must have size and width of 0 if there is a only a single collection
	func test_bounding_box_singular_computed_correctly() throws {
		try docUnderTest.createCollection(titled: "singular", at: CGPoint(x: -128, y: 64))
		
		XCTAssertEqual(docUnderTest.boundingBox, CGRect(x: -128, y: 64, width: 0, height: 0))
	}
	
	// We must get a bounding box of zero if there are no collections on the board
	func test_bounding_box_is_zero_if_no_collections() {
		XCTAssertEqual(docUnderTest.boundingBox, .zero)
	}
	
	// We must be able to adjust the collections' positions to recentre them
	func test_collections_recentered_correctly() throws {
		
	}
	
	// MARK: Collection interactions
	// The default for a new collection should have a unique name and with position zero
	func test_create_collection_no_params() throws {
		// Check there are no other collections
		XCTAssertEqual(docUnderTest.collections.count, 0)
		
		// Create the collection
		try docUnderTest.createCollection()
		
		let collectionID = Array(docUnderTest.collectionIDs)[0]
		
		// Validate it was created with position zero
		XCTAssertEqual(docUnderTest.collections.count, 1)
		XCTAssertEqual(docUnderTest.collections[collectionID]!.x, 0)
		XCTAssertEqual(docUnderTest.collections[collectionID]!.y, 0)
		
	}
	
	// We must be able to create a collection successfully
	func test_create_collection_unique() throws {
		// Create a collection
		try docUnderTest.createCollection(titled: "test 1")
		
		// Check there is exactly 1 collection
		XCTAssertEqual(docUnderTest.collections.count, 1)
		
		// Create the collection
		let collectionID2 = "test 2"
		try docUnderTest.createCollection(titled: collectionID2, at: CGPoint(x: 32, y: 56))
		
		// Validate it was created with position zero
		XCTAssertEqual(docUnderTest.collections.count, 2)
		XCTAssertEqual(docUnderTest.collections[collectionID2]!.x, 32)
		XCTAssertEqual(docUnderTest.collections[collectionID2]!.y, 56)
	}
	
	// We must NOT be able to create a collection with a non-unique name
	func test_create_collection_non_unique() throws {
		let collectionName = "test 1"
		
		// Create a collection
		try docUnderTest.createCollection(titled: collectionName)
		
		// Check there are no other collections
		XCTAssertEqual(docUnderTest.collections.count, 1)
		
		// Create the collection with the same name
		XCTAssertThrowsError(try docUnderTest.createCollection(titled: collectionName))
		
		// Check there are no new collections
		XCTAssertEqual(docUnderTest.collections.count, 1)
	}
	
	// We must be able to get a collection by its ID successfully
	func test_get_collection_by_id() throws {
		let collectionName = "test 1"
		let collectionLocation = CGPoint(x: 32, y: 56)
		
		try docUnderTest.createCollection(titled: collectionName, at: collectionLocation)
		let recalledCollection = docUnderTest.getCollection(titled: collectionName)
		XCTAssertNotNil(recalledCollection)
		
		XCTAssertEqual(recalledCollection!.x, Int(collectionLocation.x))
		XCTAssertEqual(recalledCollection!.y, Int(collectionLocation.y))
	}
	
	// We must be able to get all collections
	func test_get_all_collections() throws {
		// Check there are no other collections
		XCTAssertEqual(docUnderTest.collections.count, 0)
		
		let id1 = "test col 1"
		let id2 = "test col 2"
		let id3 = "test col 3"
		
		try docUnderTest.createCollection(titled: id1)
		try docUnderTest.createCollection(titled: id2)
		try docUnderTest.createCollection(titled: id3)
		
		let collections = docUnderTest.collections
		
		XCTAssertEqual(collections[id1]!.id, id1)
		XCTAssertEqual(collections[id2]!.id, id2)
		XCTAssertEqual(collections[id3]!.id, id3)
	}
	
	// We must be able to move a collection's position
	func test_change_position_of_collection() throws {
		
	}
	
	// We must be able to rename a collection with a unique name
	func test_rename_collection_unique() throws {
		
	}
	
	// We must NOT be able to rename a collection to a non-unique name
	func test_rename_collection_non_unique() throws {
		
	}
	
	// We must be able to toggle when a collection is locked
	func test_toggle_collection_locked() throws {
		
	}
	
	// We must be able to delete a collection
	func test_delete_collection() throws {
		
	}
	
	// MARK: Note interactions
	// We must be able to create a note successfully
	
	// We must be able to read a note successfully
	
	// We must be able to update a note successfully
	
	// We must be able to delete a note successfully
}
