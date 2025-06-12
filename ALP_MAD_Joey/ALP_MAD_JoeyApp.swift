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
    @StateObject private var session = SessionViewModel()
    @StateObject private var userViewModel: UserViewModel
    @StateObject private var moodViewModel: MoodViewModel
    @StateObject private var meditationSessionViewModel: MeditationSessionViewModel

    @State private var isLoading = true

    var sharedModelContainer: ModelContainer

    init() {
        let schema = Schema([UserModel.self, MoodModel.self])
        let config = ModelConfiguration(schema: schema)
        let container = try! ModelContainer(for: schema, configurations: [config])
        sharedModelContainer = container

        _userViewModel = StateObject(wrappedValue: UserViewModel(context: container.mainContext))
        _moodViewModel = StateObject(wrappedValue: MoodViewModel(context: container.mainContext))
        _meditationSessionViewModel = StateObject(wrappedValue: MeditationSessionViewModel(context: container.mainContext))
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
            .environmentObject(userViewModel)
            .environmentObject(moodViewModel)
            .environmentObject(meditationSessionViewModel)
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
