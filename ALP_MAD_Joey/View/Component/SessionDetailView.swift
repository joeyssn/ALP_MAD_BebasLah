//
//  SessionDetail.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 04/06/25.
//

import SwiftUI

struct SessionDetailView: View {
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
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 10)

                Image(card.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)

                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(card.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text(
                                "\(formatDuration(matchingSession?.duration)) • \(matchingSession?.soundFile ?? "No sound")"
                            )
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))

                            Text(card.med_description)
                                .font(.body)
                                .foregroundColor(.gray.opacity(0.9))
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)

                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Featured Session")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))

                        HStack(spacing: 16) {
                            ForEach(
                                MeditationData.meditationCards
                                    .filter {
                                        $0.meditationCardId
                                            != card.meditationCardId
                                    }
                                    .prefix(2),
                                id: \.meditationCardId
                            ) { sessionCard in
                                NavigationLink(
                                    destination: SessionDetailView(
                                        card: sessionCard)
                                ) {
                                    MeditationCardView(card: sessionCard)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }

                        Button(action: {
                            showSessionStart = true
                        }) {
                            Text("Start Meditating")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(
                                    Color(
                                        red: 103 / 255, green: 0,
                                        blue: 220 / 255)
                                )
                                .cornerRadius(12)
                        }
                        .padding(.top, 24)
                        .padding(.bottom, 32)
                        // Pass both card and matching session
                        .fullScreenCover(isPresented: $showSessionStart) {
                            if let session = matchingSession {
                                SessionStartView(
                                    card: card, cardSession: session)
                            } else {
                                Text("No session available")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .background(Color.black)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Preview

#Preview {
    SessionDetailView(
        card: MeditationData.meditationCards[3]  // Mountain Serenity
    )
}
