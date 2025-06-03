//
//  HomeView.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import SwiftUI

struct HomeView: View {
    private var currentHour: Int {
        Calendar.current.component(.hour, from: Date())
    }

    private var currentDayIndex: Int {
        Calendar.current.component(.weekday, from: Date()) - 1
    }

    private let meditationCards = [
        MeditationCardModel(
            imageName: "gambar1",
            title: "Moonlight Mind",
            description:
                "A calming nighttime practice to release the day and embrace rest."
        ),
        MeditationCardModel(
            imageName: "gambar2",
            title: "The Quiet Within",
            description:
                "An introspective meditation to listen to the wisdom of your inner self."
        ),
        MeditationCardModel(
            imageName: "gambar3",
            title: "Ocean Waves",
            description:
                "Let the rhythm of waves guide you to peaceful tranquility."
        ),
        MeditationCardModel(
            imageName: "gambar4",
            title: "Mountain Serenity",
            description: "Find stability and strength in mountain meditation."
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

                        Text("Calvin Laiman")
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
                        .scaledToFit()
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
                                ForEach(meditationCards, id: \.title) { card in
                                    MeditationCardView(card: card)
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
    }
}

#Preview {
    HomeView()
}
