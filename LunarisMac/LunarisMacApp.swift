//
//  LunarisMacApp.swift
//  LunarisMac
//
//  Created by Christianto Elvern Haryanto on 11/06/25.
//

import SwiftUI
import SwiftData

@main
struct LunarisMacApp: App {
    @StateObject private var session = SessionController()
    @StateObject private var userController: UserController
    @StateObject private var moodController: MoodController
    @StateObject private var meditationController: MeditationController
    @StateObject private var meditationSessionController: MeditationSessionController

    @State private var isLoading = true

    var sharedModelContainer: ModelContainer

    init() {
        let schema = Schema([
            UserModel.self,
            MoodModel.self
        ])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        let container = try! ModelContainer(for: schema, configurations: [config])
        sharedModelContainer = container

        _userController = StateObject(wrappedValue: UserController(context: container.mainContext))
        _moodController = StateObject(wrappedValue: MoodController(context: container.mainContext))
        _meditationController = StateObject(wrappedValue: MeditationController(context: container.mainContext))
        _meditationSessionController = StateObject(wrappedValue: MeditationSessionController(context: container.mainContext))
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if isLoading {
                    MacLoadingView()
                } else if session.currentUser == nil {
                    MacLoginView()
                } else {
                    MacHomeView()
                }
            }
            .environmentObject(session)
            .environmentObject(userController)
            .environmentObject(moodController)
            .environmentObject(meditationController)
            .environmentObject(meditationSessionController)
            .modelContainer(sharedModelContainer)
            .frame(minWidth: 600, minHeight: 400)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        }
    }
}
