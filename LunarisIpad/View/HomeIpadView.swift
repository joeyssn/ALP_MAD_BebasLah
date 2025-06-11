//
//  HomeIpadView.swift
//  ALP_MAD_Joey
//
//  Created by Calvin Laiman on 11/06/25.
//

import SwiftUI
import SwiftData

struct HomeIpadView: View {
    @EnvironmentObject var session: SessionViewModel
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
            GeometryReader { geometry in
                ZStack {
                    Image("Login")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            HStack {
                                Spacer()
                                HStack(spacing: 24) {
                                    NavigationLink(destination: MoodLogIpadView()) {
                                        Image(systemName: "face.smiling")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                            .frame(width: 40, height: 40)
                                            .background(Color.white.opacity(0.15))
                                            .clipShape(Circle())
                                    }
                                    
                                    NavigationLink(destination: NotificationSettingIpadView()) {
                                        Image(systemName: "bell")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                            .frame(width: 40, height: 40)
                                            .background(Color.white.opacity(0.15))
                                            .clipShape(Circle())
                                    }
                                    
                                    NavigationLink(destination: ProfileIpadView()) {
                                        Image(systemName: "gearshape")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                            .frame(width: 40, height: 40)
                                            .background(Color.white.opacity(0.15))
                                            .clipShape(Circle())
                                    }
                                }
                            }
                            .padding(.horizontal, 32)
                            .padding(.top, 10)

                            VStack(spacing: 6) {
                                Text(greeting)
                                    .foregroundColor(.white.opacity(0.9))
                                    .font(.title2)
                                    .fontWeight(.medium)

                                Text(session.currentUser?.username ?? "User")
                                    .foregroundColor(.white)
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                            }
                            .multilineTextAlignment(.center)
                            .padding(.top, 16)

                            HStack(spacing: 12) {
                                ForEach(0..<days.count, id: \.self) { index in
                                    Text(days[index])
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .frame(width: 40, height: 40)
                                        .background(
                                            currentDayIndex == index
                                                ? Color.purple
                                                : Color.white.opacity(0.15)
                                        )
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(
                                                    currentDayIndex == index
                                                        ? Color.white.opacity(0.8) : Color.clear,
                                                    lineWidth: 2
                                                )
                                        )
                                        .scaleEffect(currentDayIndex == index ? 1.05 : 1.0)
                                        .animation(.spring(response: 0.3), value: currentDayIndex)
                                }
                            }
                            .padding(.top, 12)

                            Image("starrynight")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 350)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                                .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                                .padding(.horizontal, 40)
                                .padding(.top, 20)

                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Text("Meditate Now")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                .padding(.horizontal, 40)

                                LazyVGrid(
                                    columns: [
                                        GridItem(.flexible(), spacing: 10),
                                        GridItem(.flexible(), spacing: 10),
                                    ],
                                    spacing: 12
                                ) {
                                    ForEach(MeditationData.meditationCards, id: \.title) { card in
                                        NavigationLink(destination: SessionDetailIpadView(card: card)) {
                                            MeditationCardIpadView(card: card)
                                                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal, 40)
                            }
                            .padding(.top, 20)
                            
                            Spacer(minLength: 30)
                        }
                        .frame(minHeight: geometry.size.height)
                    }
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
    let dummySession = SessionViewModel()
    dummySession.login(user: dummyUser)

    return HomeIpadView()
        .environmentObject(dummySession)
        .modelContainer(for: [UserModel.self], inMemory: true)
}
