//
//  ALP_MAD_JoeyApp.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import SwiftData
import SwiftUI

@main
struct ALP_MAD_JoeyApp: App {
    @StateObject private var session = SessionController()
    @StateObject private var userController: UserController

    var sharedModelContainer: ModelContainer
    init() {
        let schema = Schema([
            UserModel.self
                //            MeditateSessionModel.self,
                //            MoodModel.self,
                //            ReminderModel.self
        ])
        let config = ModelConfiguration(schema: schema)
        let container = try! ModelContainer(
            for: schema, configurations: [config])
        sharedModelContainer = container
        // Initialize UserController with the container's main context
        _userController = StateObject(
            wrappedValue: UserController(context: container.mainContext))

    }
    var body: some Scene {
        WindowGroup {
            StartView().environmentObject(session)
                .environmentObject(userController)
                .modelContainer(sharedModelContainer)
        }
    }
}
