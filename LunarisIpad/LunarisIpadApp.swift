//
//  LunarisIpadApp.swift
//  LunarisIpad
//
//  Created by Calvin Laiman on 10/06/25.
//

import SwiftUI
import SwiftData

@main
struct LunarisIpadApp: App {
        @StateObject private var session = SessionViewModel()
        @StateObject private var userViewModel: UserViewModel
        @StateObject private var moodViewModel: MoodViewModel
        @StateObject private var meditationViewModel: MeditationViewModel
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
            _meditationViewModel = StateObject(wrappedValue: MeditationViewModel(context: container.mainContext))
            _meditationSessionViewModel = StateObject(wrappedValue: MeditationSessionViewModel(context: container.mainContext))
        }

        var body: some Scene {
            WindowGroup {
                Group {
                    if isLoading {
                        LoadingIpadView()
                    } else {
                        RootView()
                    }
                }
                .environmentObject(session)
                .environmentObject(userViewModel)
                .environmentObject(moodViewModel)
                .environmentObject(meditationViewModel)
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
                LoginRegisterIpadView()
            } else {
                HomeIpadView()
            }
        }
    }

