//
//  HomeView.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionController
    @Environment(\.modelContext) private var context

    private var currentHour: Int {
        Calendar.current.component(.hour, from: Date())
    }

    private var currentDayIndex: Int {
        Calendar.current.component(.weekday, from: Date()) - 1
    }

    private let days = ["S", "M", "T", "W", "T", "F", "S"]

    private var greeting: String {
        switch currentHour {
        case 5..<12: return "Good Morning,"
        case 12..<17: return "Good Afternoon,"
        case 17..<20: return "Good Evening,"
        default: return "Good Night,"
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Image("Login")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        HStack(spacing: 20) {
                            NavigationLink(destination: MoodLogView()) {
                                                            Image(systemName: "face.smiling")
                                                                .foregroundColor(.white)
                                                        }
                            NavigationLink(destination: NotificationSettingsView()) {
                                Image(systemName: "bell")
                                    .foregroundColor(.white)
                            }
                            NavigationLink(destination: ProfileView()) {
                                Image(systemName: "gearshape")
                                    .foregroundColor(.white)
                            }
                        }
                        .font(.title3)
                    }
                    .padding(.horizontal)
                    .padding(.top, 50)

                    VStack(spacing: 8) {
                        Text(greeting)
                            .foregroundColor(.white.opacity(0.8))
                            .font(.title2)

                        Text(session.currentUser?.username ?? "User")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)

                    HStack(spacing: 12) {
                        ForEach(0..<days.count, id: \.self) { index in
                            Text(days[index])
                                .frame(width: 40, height: 40)
                                .background(
                                    currentDayIndex == index
                                        ? Color.purple
                                        : Color.purple.opacity(0.2)
                                )
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(
                                            currentDayIndex == index
                                                ? Color.white : Color.clear,
                                            lineWidth: 2
                                        )
                                )
                        }
                    }
                    .padding(.top, 10)

                    Image("starrynight")
                        .resizable()
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Meditate Now")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .padding(.horizontal)

                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(
                                columns: [
                                    GridItem(.flexible(), spacing: 8),
                                    GridItem(.flexible(), spacing: 8),
                                ],
                                spacing: 16
                            ) {
                                ForEach(MeditationData.meditationCards, id: \.title) { card in
                                    NavigationLink(destination: SessionDetailView(card: card)) {
                                        MeditationCardView(card: card)
                                    }
                                    .buttonStyle(PlainButtonStyle()) // Optional: To avoid the default blue highlight style
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    let dummyUser = UserModel(
        userId: 1,
        username: "Calvin",
        password: "123"
    )
    let dummySession = SessionController()
    dummySession.login(user: dummyUser)

    return HomeView()
        .environmentObject(dummySession)
        .modelContainer(for: [UserModel.self], inMemory: true)
}
