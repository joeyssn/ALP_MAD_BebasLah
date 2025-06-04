//
//  FavoriteMeditationView.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 04/06/25.
//

import SwiftUI

struct FavoriteMeditationView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Image("Login")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                    }

                    Spacer()

                    Text("Favorite List")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.semibold)

                    Spacer()

                }
                .padding(.horizontal)
                .padding(.top, 50)
                .padding(.bottom, 30)
                
                Spacer()
            }.navigationBarHidden(true)
        }
    }
}

#Preview {
    FavoriteMeditationView()
}
