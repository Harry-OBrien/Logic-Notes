//
//  CardCollectionViewModel.swift
//  Logic Notes
//
//  Created by Harry O'Brien on 16/05/2021.
//

import Foundation


class CardCollectionViewModel: ObservableObject {
	
	let apiUrl = "http://localhost/cards"
	
	@Published var notes: [Note] = [
		.init(content: "Card 1"),
		.init(content: "Card 2"),
		.init(content: "Card 3")
	]
	
	func fetchNotes() {
		guard let url = URL(string: apiUrl) else { return }
		
		URLSession.shared.dataTask(with: url) { (data, resp, err) in
			// TODO: Make sure to check error / response
			// ...
			
			// TODO: Fix unwrapping to properly handle errors (will currently crash if no data/error)
			DispatchQueue.main.async {
				self.notes = try! JSONDecoder().decode([Note].self, from: data!)
			}
			
		}
	}
}
