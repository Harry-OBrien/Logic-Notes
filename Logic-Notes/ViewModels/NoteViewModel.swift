//
//  NoteViewModel.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import Foundation
import SwiftUI
import MobileCoreServices

final class NoteViewModel: NSObject, ObservableObject, Identifiable, NSItemProviderWriting, NSItemProviderReading, Codable {
	
	let id = UUID()

	@Published var content: String
	let size = CGSize(width: 120, height: 120)
	
	static var writableTypeIdentifiersForItemProvider: [String] {
		[(kUTTypeData as String)]
	}
	
	static var readableTypeIdentifiersForItemProvider: [String] {
		[(kUTTypeData as String)]
	}

	enum CodingKeys: CodingKey {
		case content
	}
	
	init(note: Note) {
		self.content = note.content
	}
	
	required convenience init(from decoder: Decoder) {
		let container = try! decoder.container(keyedBy: CodingKeys.self)
		let noteContent = try! container.decode(String.self, forKey: .content)
		let note = Note(content: noteContent)
		
		self.init(note: note)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(self.content, forKey: .content)
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
			let subject = try decoder.decode(NoteViewModel.self, from: data)
			return subject as! Self
		} catch {
			fatalError(error.localizedDescription)
		}
	}
}
