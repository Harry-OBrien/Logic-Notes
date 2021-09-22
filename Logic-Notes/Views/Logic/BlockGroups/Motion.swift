//
//  Motion.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 12/06/2021.
//

import SwiftUI

fileprivate let motionColour = Color(r: 0x69, g: 0x96, b: 0xf9)

/// Move a collection [steps] number of steps
struct MoveSteps: View {
	
	var steps: Int
	
    var body: some View {
		InOutBlock(shapeColour: motionColour) {
			HStack {
				Text("move")
				VariablePlaceholder(borderColor: motionColour) {
					Text("\(steps)")
				}
				Text("steps")
			}
		}
    }
}

/// Set the x value of a collection to [newX]
struct SetX: View {
	
	private var newX: Int
	@State private var index: Int? = nil {
		didSet {
			// Inform model
			// The user can never set the collection back to nil, so we can safely unwrap the optional value here
			targetCollectionDidChange(collections[index!])
		}
	}
	private var targetCollectionDidChange: ((String) -> Void)
	
	private var collections: [String]
	
	init(for collectionIDs: [String], to newX: Int, targetCollectionDidChange: @escaping ((String) -> Void)) {
		self.newX = newX
		self.collections = collectionIDs
		self.targetCollectionDidChange = targetCollectionDidChange
	}
	
	var body: some View {
		InOutBlock(shapeColour: motionColour) {
			HStack {
				Text("set x coordinate of collection")
				VariableSelectionBlock(shapeColor: motionColour,
									   activeIndex: $index,
									   selection: collections)
				VariablePlaceholder(borderColor: motionColour) {
					Text("\(newX)")
				}
			}
		}
	}
}

/// Change the x value of a collection by [deltaX]
struct ChangeX: View {
	
	var deltaX: Int
	
	init(_ deltaX: Int) {
		self.deltaX = deltaX
	}
	
	var body: some View {
		InOutBlock(shapeColour: motionColour) {
			HStack {
				Text("change x by")
				VariablePlaceholder(borderColor: motionColour) {
					Text("\(deltaX)")
				}
			}
		}
	}
}

/// Set the y value of a collection to [newY]
struct SetY: View {
	
	var newY: Int
	@State private var index: Int? = nil {
		didSet {
			// Inform model
			// ...
		}
	}
//	private var indexChangedCallback: (() -> Void)
	private var collections: [String]
	
	init(for collectionIDs: [String], to newY: Int) {
		self.newY = newY
		self.collections = collectionIDs
	}
	
	var body: some View {
		InOutBlock(shapeColour: motionColour) {
			HStack {
				Text("set y coordinate of collection")
				VariableSelectionBlock(shapeColor: motionColour,
									   activeIndex: $index,
									   selection: collections)
				VariablePlaceholder(borderColor: motionColour) {
					Text("\(newY)")
				}
			}
		}
	}
}

/// Change the y value of a collection by [deltaY]
struct ChangeY: View {
	
	var deltaY: Int
	
	init(_ deltaY: Int) {
		self.deltaY = deltaY
	}
	
	var body: some View {
		InOutBlock(shapeColour: motionColour) {
			HStack {
				Text("change y by")
				VariablePlaceholder(borderColor: motionColour) {
					Text("\(deltaY)")
				}
			}
		}
	}
}

/// The variable that is tied to a collection's x-position
struct XPosition: View {
	var body: some View {
		VariableBlock(shapeColor: motionColour) {
			Text("x position")
		}
	}
}

/// The variable that is tied to a collection's y-position
struct YPosition: View {
	var body: some View {
		VariableBlock(shapeColor: motionColour) {
			Text("y position")
		}
	}
}

//struct Motion_Previews: PreviewProvider {
//    static var previews: some View {
//		VStack(alignment: .leading) {
//			MoveSteps(steps: 5)
//			ChangeX(10)
//			SetX(for: ["test 1", "to do", "collection 3"], to: 32)
//			ChangeY(10)
//			SetY(for: ["test 1", "to do", "collection 3"], to: 32)
//			XPosition()
//			YPosition()
//		}
//    }
//}
