//
//  Logic_NotesApp.swift
//  Logic Notes
//
//  Created by Harry O'Brien on 14/05/2021.
//

import SwiftUI

@main
struct Logic_NotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
