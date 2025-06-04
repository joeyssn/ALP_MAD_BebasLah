//
//  SessionStartView.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 02/06/25.
//

import SwiftUI

struct SessionStartView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    @State private var isSpread = false
    @State private var rotationAngle: Double = 0
    @State private var isPaused = false
    @State private var isLiked = false
    @EnvironmentObject var meditationController: MeditationController
    @Bindable var card: MeditationCardModel

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                    }

                    Spacer()

                    Text("Session Started")
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 6)
                VStack {

                    HStack {
                        Text("Playing: \(card.title)")
                            .font(.system(size: 18))
                            .foregroundColor(Color.gray)
                    }

                }.frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)

                Spacer().frame(height: 30)

                ZStack {
                    ForEach(0..<6, id: \.self) { index in
                        PetalShape()
                            .fill(
                                RadialGradient(
                                    colors: [
                                        Color.purple.opacity(0.8),
                                        Color.purple.opacity(0.4),
                                        Color.indigo.opacity(0.6),
                                    ],
                                    center: .center,
                                    startRadius: 20,
                                    endRadius: 80
                                )
                            )
                            .frame(width: 120, height: 120)
                            .rotationEffect(
                                .degrees(Double(index) * 60 + rotationAngle)
                            )
                            .offset(
                                x: isSpread
                                    ? cos(Double(index) * 60 * .pi / 180) * 55
                                    : 0,
                                y: isSpread
                                    ? sin(Double(index) * 60 * .pi / 180) * 55
                                    : 0
                            )
                            .scaleEffect(isSpread ? 1.2 : 0.8)
                    }
                }
                .frame(width: 300, height: 300)
                .onAppear {
                    // Infinite rotation
                    withAnimation(
                        .linear(duration: 5).repeatForever(autoreverses: false)
                    ) {
                        rotationAngle = 360
                    }

                    // Infinite spread/merge animation
                    withAnimation(
                        .easeInOut(duration: 4).repeatForever(
                            autoreverses: true)
                    ) {
                        isSpread = true
                    }
                }

                HStack {
                    Text("00:00").foregroundStyle(Color.white)
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 4)
                        .overlay(
                            HStack {
                                Rectangle()
                                    .fill(Color.purple)
                                    .frame(width: 120, height: 4)
                                Spacer()
                            }
                        )
                        .cornerRadius(2)
                    Text("00:00").foregroundStyle(Color.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 5)
                HStack(spacing: 12) {
                    Button(action: {
                        isPaused.toggle()
                    }) {
                        HStack {
                            Image(
                                systemName: isPaused
                                    ? "play.fill" : "pause.fill"
                            )
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            Text(isPaused ? "Resume" : "Pause")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            Color(
                                red: 103 / 255, green: 0 / 255, blue: 220 / 255)
                        )
                        .cornerRadius(12)
                    }

                    Button(action: {
                        card.isFavorite.toggle()
                        do {
                            try modelContext.save()  // ✅ Persist change
                        } catch {
                            print("Failed to save favorite status: \(error)")
                        }
                    }) {
                        Image(
                            systemName: card.isFavorite ? "heart.fill" : "heart"
                        )
                        .foregroundColor(card.isFavorite ? .red : .white)
                        .frame(width: 50, height: 50)
                        .background(
                            Color(
                                red: 103 / 255, green: 0 / 255, blue: 220 / 255)
                        )
                        .cornerRadius(12)
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)

                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct PetalShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        // Create a simple circle
        path.addEllipse(
            in: CGRect(
                x: center.x - radius, y: center.y - radius, width: radius * 2,
                height: radius * 2))

        return path
    }

}

#Preview {
    SessionStartView(
        card: MeditationCardModel(
            meditationCardId: 4,
            imageName: "gambar4",
            title: "Mountain Serenity",
            med_description:
                "Find stability and strength in mountain meditation."
        ))
}
