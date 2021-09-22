//
//  Logic_NotesApp.swift
//  Logic-Notes
//
//  Created by Harry O'Brien on 18/05/2021.
//

import SwiftUI

@main
struct Logic_NotesApp: App {
    var body: some Scene {
        WindowGroup {
			BoardView(board: Board.mockBoard1)
        }
    }
}
