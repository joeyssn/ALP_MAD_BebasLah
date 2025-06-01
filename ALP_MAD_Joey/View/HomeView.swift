//
//  HomeView.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import SwiftUI

struct HomeView: View {
    private var currentHour: Int {
        Calendar.current.component(.hour, from: Date())
    }

    private var currentDayIndex: Int {
        Calendar.current.component(.weekday, from: Date()) - 1
    }

    private var greeting: String {
        switch currentHour {
        case 5..<12: return "Good Morning,"
        case 12..<17: return "Good Afternoon,"
        case 17..<20: return "Good Evening,"
        default: return "Good Night,"
        }
    }

    private let days = ["S", "M", "T", "W", "T", "F", "S"]
    var body: some View {
        ZStack(alignment: .top) {
            Image("Login")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    HStack(spacing: 20) {
                        Image(systemName: "bell")
                        Image(systemName: "gearshape")
                    }
                    .foregroundColor(.white)
                    .font(.title3)
                }
                .padding(.horizontal)
                .padding(.top, 50)

                VStack(spacing: 8) {
                    Text(greeting)
                        .foregroundColor(.white.opacity(0.8))
                        .font(.title2)

                    Text("Calvin Laiman")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .multilineTextAlignment(.center)
                .padding(.top, 20)

                HStack(spacing: 12) {
                    ForEach(0..<days.count, id: \.self) { index in
                        Text(days[index])
                            .frame(width: 40, height: 40)
                            .background(
                                currentDayIndex == index
                                ? Color.purple : Color.purple.opacity(0.2)
                            )
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        currentDayIndex == index
                                            ? Color.white : Color.clear,
                                        lineWidth: 2
                                    )
                            )
                    }
                }
                .padding(.top, 10)

                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
