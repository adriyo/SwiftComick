//
// SwiftComickApp.swift
// SwiftComick
//
// Created by Adri Driyo on 22/07/23.
// Copyright (c) 2023 @adriyoutomo. All rights reserved.
//
// github.com/adriyo
//


import SwiftUI

@main
struct SwiftComickApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.commands {
            ToolbarCommands()
        }
    }
}
