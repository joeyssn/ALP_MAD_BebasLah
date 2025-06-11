//
//  MeditationCardView.swift
//  ALP_MAD_Joey
//
//  Created by Calvin Laiman on 02/06/25.
//

import SwiftUI

struct MeditationCardView: View {
    let card: MeditationCardModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Image(card.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack {
                    HStack {
                        Spacer()
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
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.top, 8)
                    .padding(.trailing, 8)
                    
                    Spacer()
                }
            }
            .frame(height: 120)
            
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
            .padding(.top, 12)
        }
    }
}
