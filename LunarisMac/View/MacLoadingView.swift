//
//  MacLoadingView.swift
//  LunarisMac
//
//  Created by Christianto Elvern Haryanto on 11/06/25.
//

import SwiftUI

struct MacLoadingView: View {
    @State private var logoOpacity = 0.0
    @State private var logoOffset: CGFloat = -80
    @State private var logoScale: CGFloat = 0.8
    @State private var textOpacity = 0.0
    @State private var textOffset: CGFloat = 80
    @State private var textScale: CGFloat = 0.9
    @State private var backgroundOpacity = 0.0
    @State private var progressOpacity = 0.0
    @State private var progressRotation: Double = 0

    var body: some View {
        ZStack {
            // Background Image
            Image("Login")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(backgroundOpacity)
                .animation(.easeIn(duration: 0.8), value: backgroundOpacity)
            
            // Dark overlay for better contrast
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .opacity(backgroundOpacity)
                .animation(.easeIn(duration: 0.8), value: backgroundOpacity)
            
            VStack(spacing: 20) {
                // Logo
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(24)
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                    .opacity(logoOpacity)
                    .offset(y: logoOffset)
                    .scaleEffect(logoScale)
                    .animation(.spring(response: 1.2, dampingFraction: 0.8, blendDuration: 0), value: logoOpacity)
                    .animation(.spring(response: 1.2, dampingFraction: 0.8, blendDuration: 0), value: logoOffset)
                    .animation(.spring(response: 1.2, dampingFraction: 0.8, blendDuration: 0), value: logoScale)

                // App Name
                Text("Lunaris")
                    .font(.system(size: 64, weight: .bold, design: .rounded))
                    .overlay(
                        LinearGradient(
                            colors: [.white, .blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(
                            Text("Lunaris")
                                .font(.system(size: 64, weight: .bold, design: .rounded))
                        )
                    )
                    .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 4)
                    .opacity(textOpacity)
                    .offset(y: textOffset)
                    .scaleEffect(textScale)
                    .animation(.spring(response: 1.2, dampingFraction: 0.8, blendDuration: 0).delay(0.4), value: textOpacity)
                    .animation(.spring(response: 1.2, dampingFraction: 0.8, blendDuration: 0).delay(0.4), value: textOffset)
                    .animation(.spring(response: 1.2, dampingFraction: 0.8, blendDuration: 0).delay(0.4), value: textScale)
                
                // Loading Indicator
                VStack(spacing: 24) {
                    // Custom rotating circle
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(
                            LinearGradient(
                                colors: [.blue, .purple, .clear],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            style: StrokeStyle(lineWidth: 3, lineCap: .round)
                        )
                        .frame(width: 40, height: 40)
                        .rotationEffect(Angle(degrees: progressRotation))
                        .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: progressRotation)
                        .opacity(progressOpacity)
                        .animation(.easeIn(duration: 0.5).delay(1.2), value: progressOpacity)
                    
                    // Loading text
                    Text("Loading...")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                        .opacity(progressOpacity)
                        .animation(.easeIn(duration: 0.5).delay(1.4), value: progressOpacity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(minWidth: 800, minHeight: 600)
        .onAppear {
            startAnimationSequence()
        }
    }
    
    private func startAnimationSequence() {
        // Background fade in
        backgroundOpacity = 1.0
        
        // Logo animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            logoOpacity = 1.0
            logoOffset = 0
            logoScale = 1.0
        }
        
        // Text animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            textOpacity = 1.0
            textOffset = 0
            textScale = 1.0
        }
        
        // Progress indicator
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            progressOpacity = 1.0
            progressRotation = 360
        }
    }
}

#Preview {
    MacLoadingView()
        .frame(width: 1000, height: 700)
}
