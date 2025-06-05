//
//  MoodView.swift
//  ALP_MAD_Joey
//
//  Created by Calvin Laiman on 03/06/25.
//

import SwiftUI
import SwiftData

struct MoodView: View {
    @State private var selectedMood: MoodType = .normal
    @State private var pulseAnimation = false
    @State private var rotationAnimation = 0.0
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var session: SessionViewModel
    @EnvironmentObject var moodViewModel: MoodViewModel

    private let moods: [MoodType] = [.unhappy, .sad, .normal, .good, .happy]

    var body: some View {
        ZStack {
            Image("Login")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 40) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                    }

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 50)

                Spacer()

                Text("How do you feel today?")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .opacity(pulseAnimation ? 0.8 : 1.0)
                    .animation(
                        .easeInOut(duration: 2.0).repeatForever(
                            autoreverses: true
                        ),
                        value: pulseAnimation
                    )

                ZStack {
                    Circle()
                        .fill(selectedMood.color.opacity(0.2))
                        .frame(width: 220, height: 220)
                        .scaleEffect(pulseAnimation ? 1.1 : 1.0)
                        .animation(
                            .easeInOut(duration: 2.0).repeatForever(
                                autoreverses: true
                            ),
                            value: pulseAnimation
                        )

                    Circle()
                        .fill(selectedMood.color.opacity(0.4))
                        .frame(width: 180, height: 180)
                        .scaleEffect(pulseAnimation ? 1.05 : 1.0)
                        .animation(
                            .easeInOut(duration: 1.5).repeatForever(
                                autoreverses: true
                            ),
                            value: pulseAnimation
                        )

                    Circle()
                        .fill(selectedMood.color)
                        .frame(width: 140, height: 140)
                        .shadow(
                            color: selectedMood.color.opacity(0.6),
                            radius: 20,
                            x: 0,
                            y: 0
                        )
                        .scaleEffect(pulseAnimation ? 1.02 : 1.0)
                        .animation(
                            .easeInOut(duration: 1.0).repeatForever(
                                autoreverses: true
                            ),
                            value: pulseAnimation
                        )

                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.6),
                                    Color.white.opacity(0.2),
                                    Color.clear,
                                ]),
                                center: .topLeading,
                                startRadius: 10,
                                endRadius: 60
                            )
                        )
                        .frame(width: 140, height: 140)
                        .rotationEffect(.degrees(rotationAnimation))
                        .animation(
                            .linear(duration: 8.0).repeatForever(
                                autoreverses: false
                            ),
                            value: rotationAnimation
                        )
                }
                .padding(.vertical, 20)
                .onAppear {
                    pulseAnimation = true
                    rotationAnimation = 360
                }

                VStack(spacing: 20) {
                    HStack(spacing: 8) {
                        ForEach(moods, id: \.self) { mood in
                            VStack(spacing: 8) {
                                Button(action: {
                                    withAnimation(
                                        .spring(
                                            response: 0.6,
                                            dampingFraction: 0.8
                                        )
                                    ) {
                                        selectedMood = mood
                                    }
                                }) {
                                    ZStack {
                                        if selectedMood == mood {
                                            Circle()
                                                .stroke(
                                                    mood.color,
                                                    lineWidth: 3
                                                )
                                                .frame(width: 35, height: 35)
                                                .scaleEffect(
                                                    pulseAnimation ? 1.1 : 1.0
                                                )
                                                .animation(
                                                    .easeInOut(duration: 1.0)
                                                        .repeatForever(
                                                            autoreverses: true
                                                        ),
                                                    value: pulseAnimation
                                                )
                                        }

                                        Circle()
                                            .fill(mood.color)
                                            .frame(width: 24, height: 24)
                                            .shadow(
                                                color: mood.color.opacity(0.5),
                                                radius: selectedMood == mood
                                                    ? 8 : 4
                                            )
                                    }
                                }
                                .scaleEffect(selectedMood == mood ? 1.2 : 1.0)
                                .animation(
                                    .spring(
                                        response: 0.4,
                                        dampingFraction: 0.6
                                    ),
                                    value: selectedMood
                                )

                                Text(mood.title)
                                    .foregroundColor(
                                        selectedMood == mood
                                            ? .white : .white.opacity(0.7)
                                    )
                                    .font(.caption)
                                    .fontWeight(
                                        selectedMood == mood
                                            ? .semibold : .medium
                                    )
                                    .scaleEffect(
                                        selectedMood == mood ? 1.1 : 1.0
                                    )
                                    .animation(
                                        .spring(
                                            response: 0.4,
                                            dampingFraction: 0.6
                                        ),
                                        value: selectedMood
                                    )
                                    .fixedSize(
                                        horizontal: true,
                                        vertical: false
                                    )
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 16)

                    Rectangle()
                        .fill(selectedMood.color.opacity(0.4))
                        .frame(height: 2)
                        .padding(.horizontal, 40)
                        .animation(
                            .easeInOut(duration: 0.5),
                            value: selectedMood
                        )
                }

                Spacer()

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    do {
                        try moodViewModel.logMood(
                            moodName: selectedMood.title,
                            for: session.currentUser?.userId ?? -1
                        )
                    } catch {
                        print(
                            "Failed to log mood: \(error.localizedDescription)"
                        )
                    }
                }) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .font(.title3)
                        Text("Log Mood")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                selectedMood.color.opacity(0.8),
                                selectedMood.color,
                                selectedMood.color.opacity(0.8),
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(
                        color: selectedMood.color.opacity(0.4),
                        radius: 10,
                        x: 0,
                        y: 5
                    )
                    .scaleEffect(pulseAnimation ? 1.02 : 1.0)
                    .animation(
                        .easeInOut(duration: 2.0).repeatForever(
                            autoreverses: true
                        ),
                        value: pulseAnimation
                    )
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 80)
            }
            .navigationBarHidden(true)
        }
    }
}

enum MoodType: CaseIterable {
    case unhappy, sad, normal, good, happy

    var color: Color {
        switch self {
        case .unhappy: return Color.red
        case .sad: return Color.blue
        case .normal: return Color.purple
        case .good: return Color.green
        case .happy: return Color.yellow
        }
    }

    var title: String {
        switch self {
        case .unhappy: return "Unhappy"
        case .sad: return "Sad"
        case .normal: return "Normal"
        case .good: return "Good"
        case .happy: return "Happy"
        }
    }
}

#Preview {
    MoodView()
}
