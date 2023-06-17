//
//  ToDoApp.swift
//  ToDo
//
//  Created by Krystian Grabowy on 17/06/2023.
//

import SwiftUI

@main
struct TodoAppApp: App {
    
    let persistenceContainer = CoreDataManager.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.viewContext)
        }
    }
}
