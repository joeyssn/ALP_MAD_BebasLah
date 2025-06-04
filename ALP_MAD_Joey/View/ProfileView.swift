//
//  ProfileView.swift
//  ALP_MAD_Joey
//
//  Created by Calvin Laiman on 02/06/25.
//

import SwiftData
import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var session: SessionController
    @Environment(\.modelContext) private var context

    var body: some View {
        if let user = session.currentUser {
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

                        Text("Profile")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.semibold)

                        Spacer()

                        Button(action: {}) {
                            Image(systemName: "pencil")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 50)
                    .padding(.bottom, 30)

                    ScrollView {
                        VStack(spacing: 30) {
                            VStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color.purple, Color.blue,
                                                ]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 120, height: 120)

                                    Image(systemName: "person.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.white)
                                }

                                VStack(spacing: 4) {
                                    Text(user.username)
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .fontWeight(.bold)

                                    Text("Meditation Enthusiast")
                                        .foregroundColor(.white.opacity(0.7))
                                        .font(.subheadline)
                                }
                            }

                            HStack(spacing: 30) {
                                VStack(spacing: 8) {
                                    Text("15")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Days Streak")
                                        .foregroundColor(.white.opacity(0.7))
                                        .font(.caption)
                                }

                                Rectangle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 1, height: 40)

                                VStack(spacing: 8) {
                                    Text("42")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Sessions")
                                        .foregroundColor(.white.opacity(0.7))
                                        .font(.caption)
                                }

                                Rectangle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 1, height: 40)

                                VStack(spacing: 8) {
                                    Text("8h 30m")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Total Time")
                                        .foregroundColor(.white.opacity(0.7))
                                        .font(.caption)
                                }
                            }
                            .padding(.horizontal)

                            VStack(spacing: 20) {
                                VStack(spacing: 20) {
                                    NavigationLink(
                                        destination: NotificationSettingsView()
                                    ) {
                                        ProfileMenuItem(
                                            icon: "bell.fill",
                                            title: "Notifications",
                                            subtitle: "Reminder settings"
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())  // Makes the whole area tappable without default styling

                                    NavigationLink(
                                        destination: FavoriteMeditationView()
                                    ) {
                                        ProfileMenuItem(
                                            icon: "heart.fill",
                                            title: "Favorites",
                                            subtitle: "Your liked meditations"
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())

                                    NavigationLink(
                                        destination: Text("History View")
                                    ) {
                                        ProfileMenuItem(
                                            icon: "clock.fill",
                                            title: "History",
                                            subtitle: "Previous sessions"
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())

                                    NavigationLink(
                                        destination: Text("Progress View")
                                    ) {
                                        ProfileMenuItem(
                                            icon: "chart.bar.fill",
                                            title: "Progress",
                                            subtitle: "Track your journey"
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())

                                    NavigationLink(
                                        destination: Text("Help & Support View")
                                    ) {
                                        ProfileMenuItem(
                                            icon: "questionmark.circle.fill",
                                            title: "Help & Support",
                                            subtitle: "Get assistance"
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())

                                    NavigationLink(
                                        destination: AboutPhoneView()
                                    ) {
                                        ProfileMenuItem(
                                            icon: "info.circle.fill",
                                            title: "About",
                                            subtitle: "App information"
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .padding(.horizontal)

                                // Sign Out Button
                                Button(action: {
                                    session.logout()
                                }) {
                                    HStack {
                                        Image(systemName: "rectangle.portrait.and.arrow.right")
                                        Text("Sign Out")
                                    }
                                    .foregroundColor(.red)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white.opacity(0.1))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.red.opacity(0.5), lineWidth: 1)
                                            )
                                    )
                                    .padding(.horizontal)
                                    .padding(.top, 20)
                                }
                                .buttonStyle(PlainButtonStyle()) // keeps the button from using default blue style and highlight


                                Spacer(minLength: 100)
                            }
                        }
                    }
                }
                .navigationBarHidden(true)
            }
        }

    }

    struct ProfileMenuItem: View {
        let icon: String
        let title: String
        let subtitle: String

        var body: some View {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .foregroundColor(.purple)
                    .font(.title2)
                    .frame(width: 24)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .foregroundColor(.white)
                        .font(.headline)
                        .fontWeight(.medium)

                    Text(subtitle)
                        .foregroundColor(.white.opacity(0.7))
                        .font(.subheadline)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.5))
                    .font(.footnote)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
        }
    }
}

#Preview {
    ProfileView()
}
