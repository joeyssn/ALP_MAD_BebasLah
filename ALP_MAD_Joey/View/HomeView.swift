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

    private let meditationCards = [
        MeditationCardModel(
            meditationCardId: 1,
            imageName: "gambar1",
            title: "Moonlight Mind",
            med_description:
                "A calming nighttime practice to release the day and embrace rest."
        ),
        MeditationCardModel(
            meditationCardId: 2,
            imageName: "gambar2",
            title: "The Quiet Within",
            med_description:
                "An introspective meditation to listen to the wisdom of your inner self."
        ),
        MeditationCardModel(
            meditationCardId: 3,
            imageName: "gambar3",
            title: "Ocean Waves",
            med_description:
                "Let the rhythm of waves guide you to peaceful tranquility."
        ),
        MeditationCardModel(
            meditationCardId: 4,
            imageName: "gambar4",
            title: "Mountain Serenity",
            med_description:
                "Find stability and strength in mountain meditation."
        ),
    ]

    private var greeting: String {
        switch currentHour {
        case 5..<12: return "Good Morning,"
        case 12..<17: return "Good Afternoon,"
        case 17..<20: return "Good Evening,"
        default: return "Good Night,"
        }
    }

    private let days = ["S", "M", "T", "W", "T", "F", "S"]

    var body: some View {
        if let user = session.currentUser {
            NavigationView {
                ZStack(alignment: .top) {
                    Image("Login")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        HStack {
                            Spacer()
                            HStack(spacing: 20) {
                                Image(systemName: "bell")
                                    .foregroundColor(.white)

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

                            Text(user.username)
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
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 8)
                                    )
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
                                    ForEach(meditationCards, id: \.title) {
                                        card in
                                        NavigationLink(
                                            destination: SessionDetailView(
                                                card: card)
                                        ) {
                                            MeditationCardView(card: card)
                                        }
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
        } else {
            Text("Current User Not Found")
        }

    }
}

#Preview {
    let dummyUser = UserModel(
        userId: 1,
        username: "steven",
        password: "123"
    )
    let dummySession = SessionController()
    dummySession.login(user: dummyUser)
    dummySession.login(user: dummyUser)
    return HomeView().environmentObject(dummySession)
        .modelContainer(for: [UserModel.self], inMemory: true)
}
