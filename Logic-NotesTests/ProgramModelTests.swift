//
//  ProgramModelTests.swift
//  Logic-NotesTests
//
//  Created by Harry O'Brien on 22/09/2021.
//

import XCTest
@testable import Logic_Notes

class ProgramModelTests: XCTestCase {

	private let jsonFileName = "ProgramJSON"
	private var mockJSONData: Data!
	
	override func setUpWithError() throws {
		try super.setUpWithError()
		
		if let url = Bundle.main.url(forResource: jsonFileName, withExtension: ".json") {
			self.mockJSONData = try Data(contentsOf: url)
		}
		else {
			XCTFail("JSON file not loaded correctly")
		}
	}
	
	override func tearDownWithError() throws {
		
	}
	
	func test_program_decodes_json_successfully() throws {
//		do {
		let program = try JSONDecoder().decode(Program.self, from: mockJSONData)
//		} catch {
//			print(error)
//		}
		validateExpectedValues(for: program)
	}
	
	func test_program_encodes_json_successfully() throws {
		let program = Program(
			id: UUID(uuidString: "BF7CD6FF-7321-4D70-BC13-51C211DEE30D"),
			code: [
				FlagPressedLogicBlock(id: UUID(uuidString: "82A020FD-874D-4316-BC89-14465890D42C")),
				SetXLogicBlock(id: UUID(uuidString: "68700059-FFAD-4155-BEAB-CD523983008C"), referencedCollection: "Collection 1", xVal: 32),
				SetYLogicBlock(id: UUID(uuidString: "D1884009-2EB6-43E4-94CB-5A58C08FBEAE"), referencedCollection: nil, yVal: 128),
				SayLogicBlock(id: UUID(uuidString: "1EE3AC82-A3F7-413E-8C28-342AA0A6FF40"), content: "Test program complete!")
			],
			trigger: .flagPressed)
		
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		
		let encodedJSON = try encoder.encode(program)
		print(NSString(data: encodedJSON, encoding: String.Encoding.utf8.rawValue)!)
		
		let decodedResult = try JSONDecoder().decode(Program.self, from: encodedJSON)
		validateExpectedValues(for: decodedResult)
	}
	
	private func validateExpectedValues(for program: Program) {
		// test to see if program has all the correct components
		XCTAssertEqual(program.id, UUID(uuidString: "BF7CD6FF-7321-4D70-BC13-51C211DEE30D"))
		
		let flagPressedBlock = program.code[0] as! FlagPressedLogicBlock
		XCTAssertEqual(flagPressedBlock.id, UUID(uuidString: "82A020FD-874D-4316-BC89-14465890D42C"))
		XCTAssertEqual(flagPressedBlock.type, .FlagPressed)
		
		let setXBlock = program.code[1] as! SetXLogicBlock
		XCTAssertEqual(setXBlock.id, UUID(uuidString: "68700059-FFAD-4155-BEAB-CD523983008C"))
		XCTAssertEqual(setXBlock.type, .SetX)
		XCTAssertEqual(setXBlock.referencedCollection, "Collection 1")
		XCTAssertEqual(setXBlock.xVal, 32)
		
		let setYBlock = program.code[2] as! SetYLogicBlock
		XCTAssertEqual(setYBlock.id, UUID(uuidString: "D1884009-2EB6-43E4-94CB-5A58C08FBEAE"))
		XCTAssertEqual(setYBlock.type, .SetY)
		XCTAssertEqual(setYBlock.referencedCollection, nil)
		XCTAssertEqual(setYBlock.yVal, 128)
		
		let sayBlock = program.code[3] as! SayLogicBlock
		XCTAssertEqual(sayBlock.id, UUID(uuidString: "1EE3AC82-A3F7-413E-8C28-342AA0A6FF40"))
		XCTAssertEqual(sayBlock.type, .Say)
		XCTAssertEqual(sayBlock.content, "Test program complete!")
	}
}
