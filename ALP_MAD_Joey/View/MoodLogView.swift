//
//  MoodLogView.swift
//  ALP_MAD_Joey
//
//  Created by Calvin Laiman on 04/06/25.
//

import SwiftUI

struct MoodLogView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("Login")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    VStack(spacing: 12) {
                        Text("Moods")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("See all of your logged moods here")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.1))
                                .frame(width: 120, height: 120)
                                .blur(radius: 20)
                            
                            Image(systemName: "face.smiling")
                                .font(.system(size: 60))
                                .foregroundColor(.white.opacity(0.6))
                        }
                        
                        Text("No moods logged yet")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text("Start tracking your daily emotions\nand see your patterns over time")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.6))
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: MoodView()) {
                        HStack(spacing: 12) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                            
                            Text("Add Your Mood")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.pink.opacity(0.8),
                                    Color.purple.opacity(0.9),
                                    Color.indigo.opacity(0.8)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(
                            color: Color.purple.opacity(0.4),
                            radius: 20,
                            x: 0,
                            y: 10
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

#Preview {
    MoodLogView()
}
