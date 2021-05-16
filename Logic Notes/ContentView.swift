//
//  ContentView.swift
//  Logic Notes
//
//  Created by Harry O'Brien on 14/05/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
	@State private var draggedOffset = CGSize.zero
	@State private var position = CGPoint(x: 400, y: 400)
	
	var body: some View {
		CardCollectionView(title: "Group A")
			.offset(self.draggedOffset)
			.position(self.position)
			.gesture(DragGesture()
								.onChanged { value in
									self.draggedOffset = value.translation
								}
								.onEnded { value in
									self.position.x += value.translation.width
									self.position.y += value.translation.height
									self.draggedOffset = CGSize.zero
								}
			)
	}
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
#endif
