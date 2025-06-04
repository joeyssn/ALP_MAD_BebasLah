import SwiftUI

struct SessionStartView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    @State private var isSpread = false
    @State private var rotationAngle: Double = 0
    @State private var isPaused = false
    @State private var isLiked = false
    @State private var animationTimer: Timer?
    @State private var animationTimers: [Timer] = []

    @EnvironmentObject var meditationController: MeditationController
    @EnvironmentObject var meditationSessionController: MeditationSessionController

    let card: MeditationCardModel
    let cardSession: MeditateSessionModel

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack {
                // Navigation bar
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
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)

                Spacer().frame(height: 30)

                // Animated petals
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
                            .rotationEffect(.degrees(Double(index) * 60 + rotationAngle))
                            .offset(
                                x: isSpread ? cos(Double(index) * 60 * .pi / 180) * 55 : 0,
                                y: isSpread ? sin(Double(index) * 60 * .pi / 180) * 55 : 0
                            )
                            .scaleEffect(isSpread ? 1.2 : 0.8)
                    }
                }
                .frame(width: 300, height: 300)

                // Playback progress bar (static for now)
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

                // Play/Pause and Favorite buttons
                HStack(spacing: 12) {
                    Button(action: {
                        isPaused.toggle()
                        if isPaused {
                            meditationSessionController.pauseSound()
                        } else {
                            meditationSessionController.resumeSound()
                        }
                    }) {
                        HStack {
                            Image(systemName: isPaused ? "play.fill" : "pause.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold))
                            Text(isPaused ? "Resume" : "Pause")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(red: 103 / 255, green: 0 / 255, blue: 220 / 255))
                        .cornerRadius(12)
                    }

                    Button(action: {
                        card.isFavorite.toggle()
                        do {
                            try modelContext.save()
                        } catch {
                            print("Failed to save favorite status: \(error)")
                        }
                    }) {
                        Image(systemName: card.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(card.isFavorite ? .red : .white)
                            .frame(width: 50, height: 50)
                            .background(Color(red: 103 / 255, green: 0 / 255, blue: 220 / 255))
                            .cornerRadius(12)
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)

                Spacer()
            }
            .navigationBarHidden(true)
            .onAppear {
                meditationSessionController.playSound(named: cardSession.soundFile)
                isPaused = false
                startAnimations()
            }
            .onDisappear {
                meditationSessionController.stopSound()
                stopAnimations()
            }
        }
    }

    // MARK: - Animation Control
    func startAnimations() {
        stopAnimations()

        // Continuous rotation timer
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            if !isPaused {
                rotationAngle += 0.5
            }
        }

        // Continuous spread animation toggle every 2s
        let spreadTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            if !isPaused {
                withAnimation(.easeInOut(duration: 2.0)) {
                    isSpread.toggle()
                }
            }
        }
        animationTimers.append(spreadTimer)
    }

    func stopAnimations() {
        animationTimer?.invalidate()
        animationTimer = nil

        for timer in animationTimers {
            timer.invalidate()
        }
        animationTimers.removeAll()
    }
}

// MARK: - Petal Shape
struct PetalShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        path.addEllipse(in: CGRect(x: center.x - radius, y: center.y - radius,
                                   width: radius * 2, height: radius * 2))

        return path
    }
}
