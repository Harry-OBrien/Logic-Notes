//
//  CardCollection.swift
//  Logic Notes
//
//  Created by Harry O'Brien on 15/05/2021.
//

import SwiftUI
import Foundation



struct CardCollectionView: View {
	
	@ObservedObject var collectionVM = CardCollectionViewModel()
	
	let title: String
	let backgroundColour = Color(white:237/255)
	let accentColour = Color(white: 196/255)
	let cornerRadius: CGFloat = 6
	
	var body: some View {
		VStack {
			
			Text(title)
				.font(.title)
				.frame(width: 180, height: 60, alignment: .center)
				.background(backgroundColour)
				.cornerRadius(30)
				.overlay(RoundedRectangle(cornerRadius: 30)
																.stroke(accentColour))
				.offset(y: 30)
				.zIndex(1.0)
		
				
			HStack {
				ForEach(collectionVM.notes) { note in
					NoteView(content: note.content)
				}
			}
			.frame(width: 460, height: 220, alignment: .center)
			.background(backgroundColour)
			.cornerRadius(cornerRadius)
			.overlay(
				RoundedRectangle(cornerRadius: cornerRadius)
					.stroke(accentColour)
			)
		}
	}
}

#if DEBUG
struct Card_Collection_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			CardCollectionView(title: "Group A")
		}
	}
}
#endif
