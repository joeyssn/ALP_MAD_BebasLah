import SwiftUI

struct SessionStartIpadView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    @State private var isSpread = false
    @State private var rotationAngle: Double = 0
    @State private var isPaused = false
    @State private var isLiked = false
    @State private var animationTimer: Timer?
    @State private var animationTimers: [Timer] = []
    @State private var elapsedSeconds: Int = 0
    @State private var playbackTimer: Timer?

    @EnvironmentObject var meditationViewModel: MeditationViewModel
    @EnvironmentObject var meditationSessionViewModel: MeditationSessionViewModel

    let card: MeditationCardModel
    let cardSession: MeditateSessionModel

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // Navigation Header
                    navigationHeader
                        .padding(.horizontal, 40)
                        .padding(.top, 20)
                        .padding(.bottom, 12)

                    // Playing title
                    playingTitle
                        .padding(.horizontal, 40)
                        .padding(.bottom, geometry.size.height > geometry.size.width ? 40 : 20)

                    if geometry.size.width > geometry.size.height {
                        // Landscape Layout
                        landscapeContent
                    } else {
                        // Portrait Layout
                        portraitContent
                    }
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                meditationSessionViewModel.playSound(named: cardSession.soundFile)
                isPaused = false
                elapsedSeconds = 0
                startAnimations()
                startPlaybackTimer()
            }
            .onDisappear {
                meditationSessionViewModel.stopSound()
                stopAnimations()
                stopPlaybackTimer()
            }
        }
    }
    
    // MARK: - Navigation Header
    private var navigationHeader: some View {
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
                .font(.system(size: 28))
                .fontWeight(.semibold)
                .foregroundStyle(Color.white)
            Spacer()
        }
    }
    
    // MARK: - Playing Title
    private var playingTitle: some View {
        HStack {
            Text("Playing: \(card.title)")
                .font(.system(size: 20))
                .foregroundColor(Color.gray)
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Landscape Content
    private var landscapeContent: some View {
        HStack(spacing: 60) {
            // Animation section
            animatedPetals
                .frame(width: 400, height: 400)
            
            // Controls section
            VStack(spacing: 30) {
                progressBar
                playPauseButton
                    .frame(maxWidth: 300)
            }
        }
        .padding(.horizontal, 60)
    }
    
    // MARK: - Portrait Content
    private var portraitContent: some View {
        VStack(spacing: 40) {
            animatedPetals
                .frame(width: 350, height: 350)
            
            VStack(spacing: 25) {
                progressBar
                playPauseButton
            }
            .padding(.horizontal, 40)
        }
    }
    
    // MARK: - Animated Petals
    private var animatedPetals: some View {
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
                            startRadius: 30,
                            endRadius: 100
                        )
                    )
                    .frame(width: 140, height: 140)
                    .rotationEffect(.degrees(Double(index) * 60 + rotationAngle))
                    .offset(
                        x: isSpread ? cos(Double(index) * 60 * .pi / 180) * 65 : 0,
                        y: isSpread ? sin(Double(index) * 60 * .pi / 180) * 65 : 0
                    )
                    .scaleEffect(isSpread ? 1.3 : 0.9)
            }
        }
    }
    
    // MARK: - Progress Bar
    private var progressBar: some View {
        HStack(spacing: 16) {
            Text(formatDuration(elapsedSeconds))
                .foregroundStyle(Color.white)
                .font(.system(size: 16, weight: .medium))
                .frame(width: 50)
            
            GeometryReader { geo in
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 6)
                    .overlay(
                        HStack {
                            Rectangle()
                                .fill(Color.purple)
                                .frame(
                                    width: geo.size.width * CGFloat(elapsedSeconds) / CGFloat(cardSession.duration),
                                    height: 6
                                )
                            Spacer()
                        }
                    )
                    .cornerRadius(3)
            }
            .frame(height: 6)
            
            Text(formatDuration(cardSession.duration))
                .foregroundStyle(Color.white)
                .font(.system(size: 16, weight: .medium))
                .frame(width: 50)
        }
    }
    
    // MARK: - Play/Pause Button
    private var playPauseButton: some View {
        Button(action: {
            isPaused.toggle()
            if isPaused {
                meditationSessionViewModel.pauseSound()
            } else {
                meditationSessionViewModel.resumeSound()
            }
        }) {
            HStack(spacing: 12) {
                Image(systemName: isPaused ? "play.fill" : "pause.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .bold))
                Text(isPaused ? "Resume" : "Pause")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(Color(red: 103 / 255, green: 0 / 255, blue: 220 / 255))
            .cornerRadius(16)
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
    
    func formatDuration(_ seconds: Int?) -> String {
        guard let seconds = seconds else { return "--:--" }
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
    
    func startPlaybackTimer() {
        stopPlaybackTimer() // just in case

        playbackTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if !isPaused {
                if elapsedSeconds < cardSession.duration {
                    elapsedSeconds += 1
                } else {
                    // Session ended — optionally stop timer or trigger something
                    stopPlaybackTimer()
                }
            }
        }
    }

    func stopPlaybackTimer() {
        playbackTimer?.invalidate()
        playbackTimer = nil
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
