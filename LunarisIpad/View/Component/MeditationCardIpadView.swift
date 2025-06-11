//
//  MeditationCardIpadView.swift
//  ALP_MAD_Joey
//
//  Created by Calvin Laiman on 11/06/25.
//

import SwiftUI

struct MeditationCardIpadView: View {
    let card: MeditationCardModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Image(card.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )

                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(Color.purple.opacity(0.9))
                            .frame(width: 28, height: 28)

                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    }
                }
                .padding(10)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(card.title)
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(1)

                Text(card.med_description)
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 12))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(.top, 10)
        }
    }
}
