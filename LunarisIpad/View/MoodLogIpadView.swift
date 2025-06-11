//
//  MoodLogIpadView.swift
//  ALP_MAD_Joey
//
//  Created by Calvin Laiman on 11/06/25.
//

import SwiftUI
import SwiftData

struct MoodLogIpadView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var sessionViewModel: SessionViewModel
    @EnvironmentObject var moodViewModel: MoodViewModel

    @State private var moods: [MoodModel] = []
    @State private var showMoodView = false

    var body: some View {
        ZStack {
            Image("Login")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.white)
                    }

                    Spacer()
                }
                .padding(.horizontal, 40)
                .padding(.top, 40)
                .padding(.bottom, 30)

                VStack(spacing: 40) {
                    Spacer()

                    VStack(spacing: 12) {
                        Text("Moods")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.white)

                        Text("See all of your logged moods here")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)

                    Spacer()

                    if moods.isEmpty {
                        VStack(spacing: 20) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.1))
                                    .frame(width: 140, height: 140)
                                    .blur(radius: 20)

                                Image(systemName: "face.smiling")
                                    .font(.system(size: 70))
                                    .foregroundColor(.white.opacity(0.6))
                            }

                            Text("No moods logged yet")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.white.opacity(0.8))

                            Text("Start tracking your daily emotions\nand see your patterns over time")
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.6))
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                        }
                        .padding(.horizontal)
                    } else {
                        ScrollView {
                            VStack(spacing: 20) {
                                ForEach(moods, id: \.id) { mood in
                                    HStack {
                                        Circle()
                                            .fill(colorForMood(mood.moodName))
                                            .frame(width: 20, height: 20)

                                        Text(mood.moodName)
                                            .foregroundColor(.white)
                                            .font(.headline)

                                        Spacer()

                                        Text(mood.dateLogged.formatted(date: .abbreviated, time: .shortened))
                                            .foregroundColor(.white.opacity(0.6))
                                            .font(.subheadline)
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.05))
                                    .cornerRadius(14)
                                    .padding(.horizontal, 80)
                                }
                            }
                        }
                        .frame(maxHeight: 400)
                    }

                    Spacer()

                    Button(action: {
                        showMoodView = true
                    }) {
                        HStack(spacing: 14) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)

                            Text("Add Your Mood")
                                .font(.system(size: 20, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.pink.opacity(0.8),
                                    Color.purple.opacity(0.9),
                                    Color.indigo.opacity(0.8),
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .shadow(color: Color.purple.opacity(0.4), radius: 20, x: 0, y: 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 100)
                    .padding(.bottom, 80)
                }
            }
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $showMoodView, onDismiss: fetchMoods) {
            MoodIpadView()
        }
        .onAppear(perform: fetchMoods)
    }

    private func fetchMoods() {
        do {
            moods = try moodViewModel.getMoods(for: sessionViewModel.currentUser?.userId ?? -1)
        } catch {
            print("Failed to fetch moods: \(error.localizedDescription)")
        }
    }
}

func colorForMood(_ mood: String) -> Color {
    switch mood.lowercased() {
    case "unhappy": return .red
    case "sad": return .blue
    case "normal": return .purple
    case "good": return .green
    case "happy": return .yellow
    default: return .gray
    }
}

//#Preview {
//    let dummySession = SessionController()
//    dummySession.login(user: UserModel(userId: 1, username: "Calvin", password: "123"))
//
//    return MoodLogIpadView()
//        .environmentObject(dummySession)
//        .environmentObject(MoodController())
//        .modelContainer(for: [UserModel.self], inMemory: true)
//}
