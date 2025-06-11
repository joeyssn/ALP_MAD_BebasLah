//
//  MacHomeView.swift
//  LunarisMac
//
//  Created by Christianto Elvern Haryanto on 11/06/25.
//

import SwiftData
import SwiftUI

struct MacHomeView: View {
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
        NavigationStack{
            GeometryReader { geometry in
                ZStack {
                    Image("Login")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()

                    ScrollView {
                        VStack(spacing: 30) {
                            // Top navigation buttons
                            HStack {
                                Spacer()
                                HStack(spacing: 30) {
                                    NavigationLink(destination: MoodLogView()) {
                                        Image(systemName: "face.smiling")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                    }
                                    .buttonStyle(.plain)
                                    
                                    NavigationLink(destination: NotificationSettingsView()) {
                                        Image(systemName: "bell")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                    }
                                    .buttonStyle(.plain)
                                    
                                    NavigationLink(destination: ProfileView()) {
                                        Image(systemName: "gearshape")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 40)
                            .padding(.top, 40)

                            // Greeting section
                            VStack(spacing: 12) {
                                Text(greeting)
                                    .foregroundColor(.white.opacity(0.8))
                                    .font(.title)

                                Text(session.currentUser?.username ?? "User")
                                    .foregroundColor(.white)
                                    .font(.system(size: 42, weight: .bold, design: .rounded))
                            }
                            .multilineTextAlignment(.center)
                            .padding(.top, 20)

                            // Week days
                            HStack(spacing: 16) {
                                ForEach(0..<days.count, id: \.self) { index in
                                    Text(days[index])
                                        .frame(width: 50, height: 50)
                                        .background(
                                            currentDayIndex == index
                                                ? Color.purple
                                                : Color.purple.opacity(0.2)
                                        )
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .font(.headline)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(
                                                    currentDayIndex == index
                                                        ? Color.white : Color.clear,
                                                    lineWidth: 2
                                                )
                                        )
                                }
                            }
                            .padding(.top, 20)

                            // Starry night image
                            Image("starrynight")
                                .resizable()
                                .frame(height: 240)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .padding(.horizontal, 40)

                            // Meditation section
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Meditate Now")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white.opacity(0.9))
                                    .padding(.horizontal, 40)

                                LazyVGrid(
                                    columns: [
                                        GridItem(.flexible(), spacing: 12),
                                        GridItem(.flexible(), spacing: 12),
                                        GridItem(.flexible(), spacing: 12),
                                    ],
                                    spacing: 20
                                ) {
                                    ForEach(MeditationData.meditationCards, id: \.title) { card in
                                        NavigationLink(destination: SessionDetailView(card: card)) {
                                            MeditationCardView(card: card)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal, 40)
                            }
                            .padding(.bottom, 40)
                        }
                    }
                }
            }
            .frame(minWidth: 1200, minHeight: 800)
            .navigationTitle("")
        }
        
//        .toolbar(.hidden, for: .navigationBar)
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

    return MacHomeView()
        .environmentObject(dummySession)
        .modelContainer(for: [UserModel.self], inMemory: true)
}
