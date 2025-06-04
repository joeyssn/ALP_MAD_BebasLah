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
    @StateObject private var moodController: MoodController
    @StateObject private var meditationController: MeditationController

    @State private var isLoading = true

    var sharedModelContainer: ModelContainer

    init() {
        let schema = Schema([UserModel.self, MoodModel.self])
        let config = ModelConfiguration(schema: schema)
        let container = try! ModelContainer(for: schema, configurations: [config])
        sharedModelContainer = container

        _userController = StateObject(wrappedValue: UserController(context: container.mainContext))
        _moodController = StateObject(wrappedValue: MoodController(context: container.mainContext))
        _meditationController = StateObject(wrappedValue: MeditationController(context: container.mainContext))
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if isLoading {
                    LoadingView()
                } else {
                    RootView()
                }
            }
            .environmentObject(session)
            .environmentObject(userController)
            .environmentObject(moodController)
            .environmentObject(meditationController)
            .modelContainer(sharedModelContainer)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func RootView() -> some View {
        if session.currentUser == nil {
            LoginRegisterView()
        } else {
            HomeView()
        }
    }
}
