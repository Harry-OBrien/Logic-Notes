//
//  Note.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation
import MobileCoreServices

class Note: NSObject, Identifiable, NSItemProviderWriting, NSItemProviderReading, Codable{
	var id : UUID
	var content: String
	
	static var writableTypeIdentifiersForItemProvider: [String] {
		[(kUTTypeData as String)]
	}
	
	static var readableTypeIdentifiersForItemProvider: [String] {
		[(kUTTypeData as String)]
	}
	
	enum CodingKeys: CodingKey {
		case content
		case id
	}
	
	required init(from decoder: Decoder) {
		let container = try! decoder.container(keyedBy: CodingKeys.self)
		self.content = try! container.decode(String.self, forKey: .content)
		self.id = try! container.decode(UUID.self, forKey: .id)
	}
	
	init(content: String) {
		id = UUID()
		self.content = content
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		try container.encode(self.content, forKey: .content)
		try container.encode(self.id, forKey: .id)
	}
	
	func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
		let progress = Progress(totalUnitCount: 100)
		
		do {
			let data = try JSONEncoder().encode(self)
			progress.completedUnitCount = 100
			completionHandler(data, nil)
			
		} catch {
			completionHandler(nil, error)
		}
		
		return progress
	}
	
	static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
		let decoder = JSONDecoder()
		
		do {
			let subject = try decoder.decode(Note.self, from: data)
			return subject as! Self
		} catch {
			fatalError(error.localizedDescription)
		}
	}
}
