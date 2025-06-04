//
//  AboutPhoneView.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 03/06/25.
//

import SwiftUI

struct AboutPhoneView: View {
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ZStack {
            Image("Login")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                    }

                    Spacer()

                    Text("About")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.semibold)

                    Spacer()

                    Spacer().frame(width: 28)
                }
                .padding(.horizontal)
                .padding(.top, 50)
                .padding(.bottom, 30)

                VStack(spacing: 20) {
                    Group {
                        infoRow(label: "App Name", value: "Lunaris")
                        infoRow(label: "Version", value: "1.0.0")
                        infoRow(label: "Developer", value: "Calvin Laiman")
                    }

                    Text("This app helps users meditate and improve their mental well-being with calming audio and personal progress tracking.")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                )
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationBarHidden(true)
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .foregroundColor(.white.opacity(0.7))
        }
        .font(.body)
        .padding(.vertical, 4)
    }
}

#Preview {
    AboutPhoneView()
}
