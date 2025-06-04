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

    var body: some View {
        ZStack {
            // Background gradient
            Color.black
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                    }

                    Spacer()

                    Text("Session Detail")
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 10)
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

                            Text("20 Min • Calming Song")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))

                            Text(
                                card.med_description
                                
                            )
                            .font(.body)
                            .foregroundColor(.gray.opacity(0.9))
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Featured Session").font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        HStack {
                            //                            ForEach(meditationSessions.prefix(2), id: \.id) {
                            //                                session in
                            //                                MeditationCardView(session: session)
                            //                            }
                        }
                        NavigationLink(
                            destination:
                                SessionStartView(card: card)
                            
                        ) {
                            Text("Start Meditating")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(
                                    Color(
                                        red: 103 / 255, green: 0 / 255,
                                        blue: 220 / 255)
                                )
                                .cornerRadius(12)
                        }
                        .padding(.top, 24)
                        .padding(.bottom, 32)
                    }.padding(.horizontal, 20)
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SessionDetailView(
        card: MeditationCardModel(
            meditationCardId: 4,
            imageName: "gambar4",
            title: "Mountain Serenity",
            med_description:
                "Find stability and strength in mountain meditation."
        ))
}
