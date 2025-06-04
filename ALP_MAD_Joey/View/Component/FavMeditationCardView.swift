//
//  FavMeditationCardView.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 04/06/25.
//

import SwiftUI

struct FavMeditationCardView: View {
    let card: MeditationCardModel
    @State private var isPressed = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image with cosmic overlay and star button
            ZStack {
                Image(card.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Mystical zodiac gradient overlay
                LinearGradient(
                    colors: [
                        Color.clear,
                        Color.purple.opacity(0.2),
                        Color.indigo.opacity(0.4)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            // Handle favorite toggle
                        }) {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.purple.opacity(0.9), Color.indigo.opacity(0.8)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 28, height: 28)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.pink.opacity(0.6), lineWidth: 1)
                                    )
                                
                                Image(systemName: "sparkles")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                            }
                        }
                    }
                    .padding(.top, 8)
                    .padding(.trailing, 8)
                    
                    Spacer()
                }
            }
            .frame(height: 120)
            
            // Content section with space theme
            VStack(alignment: .leading, spacing: 6) {
                Text(card.title)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, .pink.opacity(0.9)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(1)
                    .shadow(color: .purple.opacity(0.5), radius: 1, x: 0, y: 1)
                
                Text(card.med_description)
                    .foregroundColor(.white.opacity(0.9))
                    .font(.system(size: 12))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .shadow(color: .purple.opacity(0.3), radius: 1, x: 0, y: 1)
            }
            .padding(.top, 12)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.indigo.opacity(0.8),
                            Color.purple.opacity(0.4),
                            Color.pink.opacity(0.3)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(
                                colors: [Color.pink.opacity(0.8), Color.purple.opacity(0.6), Color.indigo.opacity(0.8)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.5
                        )
                )
        )
        .shadow(
            color: Color.purple.opacity(0.4),
            radius: 8,
            x: 0,
            y: 4
        )
        .shadow(
            color: Color.pink.opacity(0.2),
            radius: 2,
            x: 0,
            y: 1
        )
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .onTapGesture {
            // Handle card tap
        }
        .onLongPressGesture(
            minimumDuration: 0,
            maximumDistance: .infinity,
            pressing: { pressing in
                isPressed = pressing
            },
            perform: {}
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        FavMeditationCardView(card: MeditationCardModel(
            meditationCardId: 4,
            imageName: "gambar4",
            title: "Mountain Serenity",
            med_description: "Find stability and strength in mountain meditation. Connect with the earth and discover inner peace."
        ))
        
        FavMeditationCardView(card: MeditationCardModel(
            meditationCardId: 5,
            imageName: "gambar4",
            title: "Celestial Harmony",
            med_description: "Align your energy with the mystical forces of the universe and find your inner constellation."
        ))
    }
    .padding()
    .background(
        LinearGradient(
            colors: [Color.indigo.opacity(0.3), Color.purple.opacity(0.2), Color.pink.opacity(0.1)],
            startPoint: .top,
            endPoint: .bottom
        )
    )
}
