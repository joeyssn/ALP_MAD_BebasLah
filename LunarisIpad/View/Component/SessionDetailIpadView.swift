//
//  SessionDetail.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 04/06/25.
//

import SwiftUI

struct SessionDetailIpadView: View {
    @Environment(\.presentationMode) var presentationMode
    let card: MeditationCardModel

    @State private var showSessionStart = false

    // Find matching session by card id
    private var matchingSession: MeditateSessionModel? {
        MeditationData.meditationSessions().first {
            $0.meditationSessionId == card.meditationCardId
        }
    }
    
    // Helper function to format seconds to "m:ss"
    func formatDuration(_ seconds: Int?) -> String {
        guard let seconds = seconds else { return "--:--" }
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        if minutes != 0{
            return String(format: "%dmin %02dsec", minutes, remainingSeconds)
        }else if remainingSeconds == 0{
            return String(format: "%dmin", minutes)
        }else{
            return String(format: "%02dsec", remainingSeconds)
        }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                    }

                    Spacer()

                    Text("Session Detail")
                        .font(.system(size: 28))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 20)

                GeometryReader { geometry in
                    if geometry.size.width > geometry.size.height {
                        // Landscape orientation - side by side layout
                        HStack(spacing: 40) {
                            // Image section
                            Image(card.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: geometry.size.width * 0.4)
                                .frame(maxHeight: geometry.size.height * 0.6)
                            
                            // Content section
                            VStack(alignment: .leading, spacing: 20) {
                                contentSection
                                featuredSessionsSection
                                startButton
                                Spacer()
                            }
                            .frame(maxWidth: geometry.size.width * 0.5)
                        }
                        .padding(.horizontal, 40)
                    } else {
                        // Portrait orientation - vertical layout
                        VStack(spacing: 20) {
                            Image(card.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: min(geometry.size.width * 0.8, 500))
                                .frame(maxHeight: geometry.size.height * 0.4)
                            
                            VStack(alignment: .leading, spacing: 20) {
                                contentSection
                                featuredSessionsSection
                                startButton
                            }
                            .padding(.horizontal, 40)
                            
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Content Section
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(card.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text(
                "\(formatDuration(matchingSession?.duration)) • \(matchingSession?.soundFile ?? "No sound")"
            )
            .font(.title3)
            .foregroundColor(.white.opacity(0.8))

            Text(card.med_description)
                .font(.title3)
                .foregroundColor(.gray.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .lineSpacing(4)
        }
    }
    
    // MARK: - Featured Sessions Section
    private var featuredSessionsSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Featured Session")
                .font(.title3)
                .foregroundColor(.white.opacity(0.8))

            HStack(spacing: 24) {
                ForEach(
                    MeditationData.meditationCards
                        .filter {
                            $0.meditationCardId != card.meditationCardId
                        }
                        .prefix(2),
                    id: \.meditationCardId
                ) { sessionCard in
                    NavigationLink(
                        destination: SessionDetailIpadView(card: sessionCard)
                    ) {
                        MeditationCardIpadView(card: sessionCard)
                            .frame(maxWidth: 180)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                Spacer()
            }
        }
    }
    
    // MARK: - Start Button
    private var startButton: some View {
        Button(action: {
            showSessionStart = true
        }) {
            Text("Start Meditating")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 64)
                .background(
                    Color(red: 103 / 255, green: 0, blue: 220 / 255)
                )
                .cornerRadius(16)
        }
        .padding(.top, 32)
        .padding(.bottom, 40)
        .sheet(isPresented: $showSessionStart) {
            if let session = matchingSession {
                SessionStartIpadView(card: card, cardSession: session)
            } else {
                Text("No session available")
                    .font(.title)
                    .foregroundColor(.white)
                    .background(Color.black)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SessionDetailIpadView(
        card: MeditationData.meditationCards[3]  // Mountain Serenity
    )
}
