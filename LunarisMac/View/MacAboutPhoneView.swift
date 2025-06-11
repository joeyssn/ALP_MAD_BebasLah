//
//  AboutPhoneView.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 03/06/25.
//

import SwiftUI

struct AboutPhoneView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // Background image with proper aspect ratio handling
            GeometryReader { geometry in
                Image("Login")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header with proper macOS spacing
//                HStack {
//                    Button(action: {
//                        dismiss()
//                    }) {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(.white)
//                            .font(.title2)
//                            .frame(width: 28, height: 28)
//                    }
//                    .buttonStyle(PlainButtonStyle())
//                    .help("Go back")
//
//                    Spacer()
//
//                    Text("About")
//                        .foregroundColor(.white)
//                        .font(.title2)
//                        .fontWeight(.semibold)
//
//                    Spacer()
//
//                    Color.clear
//                        .frame(width: 28, height: 28)
//                }
//                .padding(.horizontal, 24)
//                .padding(.top, 20)
//                .padding(.bottom, 24)

                // Content area with proper constraints
                VStack(spacing: 0) {
                    VStack(spacing: 24) {
                        // App info section
                        VStack(spacing: 16) {
                            Group {
                                infoRow(label: "App Name", value: "Lunaris")
                                Divider()
                                    .background(Color.white.opacity(0.2))
                                
                                infoRow(label: "Version", value: "1.0.0")
                                Divider()
                                    .background(Color.white.opacity(0.2))
                                
                                infoRow(label: "Developer", value: "Calvin Laiman")
                            }
                        }

                        // Description section
                        VStack(spacing: 12) {
                            HStack {
                                Text("About This App")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .fontWeight(.medium)
                                Spacer()
                            }
                            
                            Text("This app helps users meditate and improve their mental well-being with calming audio and personal progress tracking.")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.1))
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                    )
                    .frame(maxWidth: 500) // Constrain maximum width
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(minWidth: 450, minHeight: 500) // Better minimum size for macOS
        .background(Color.clear)
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack(spacing: 16) {
            Text(label)
                .foregroundColor(.white)
                .font(.body)
                .fontWeight(.medium)
            
            Spacer()
            
            Text(value)
                .foregroundColor(.white.opacity(0.8))
                .font(.body)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    AboutPhoneView()
        .frame(width: 500, height: 600)
}
