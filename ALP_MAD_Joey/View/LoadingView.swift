//
//  LoadingView.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import SwiftUI

struct LoadingView: View {
    @State private var logoOpacity = 0.0
    @State private var logoOffset: CGFloat = -50
    @State private var textOpacity = 0.0
    @State private var textOffset: CGFloat = 50

    var body: some View {
        ZStack {
            Image("Login")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 70) {
                Image("Logo")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .opacity(logoOpacity)
                    .offset(y: logoOffset)
                    .animation(.easeOut(duration: 1.2), value: logoOpacity)
                    .animation(.easeOut(duration: 1.2), value: logoOffset)
                    

                Text("Lunara")
                    .font(.system(size: 50, weight: .bold))
                    .overlay(
                        LinearGradient(
                            colors: [.white, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask(
                            Text("Lunaris")
                                .font(.system(size: 50, weight: .bold))
                        )
                    )
                    .opacity(textOpacity)
                    .offset(y: textOffset)
                    .animation(.easeOut(duration: 1.2).delay(0.3), value: textOpacity)
                    .animation(.easeOut(duration: 1.2).delay(0.3), value: textOffset)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            logoOpacity = 1.0
            logoOffset = 0
            textOpacity = 1.0
            textOffset = 0
        }
    }
}

#Preview {
    LoadingView()
}
