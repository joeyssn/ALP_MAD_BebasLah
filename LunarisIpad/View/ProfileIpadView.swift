//
//  ProfileIpadView.swift
//  ALP_MAD_Joey
//
//  Created by Calvin Laiman on 11/06/25.
//

import SwiftData
import SwiftUI

struct ProfileIpadView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var session: SessionViewModel
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
                                .font(.title)
                        }

                        Spacer()

                        Text("Profile")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.semibold)

                        Spacer()

                        NavigationLink(destination: EditProfileView(user: user)) {
                            Image(systemName: "pencil")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                    .padding(.bottom, 40)

                    ScrollView {
                        VStack(spacing: 50) {
                            VStack(spacing: 24) {
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
                                        .frame(width: 160, height: 160)

                                    Image(systemName: "person.fill")
                                        .font(.system(size: 70))
                                        .foregroundColor(.white)
                                }

                                VStack(spacing: 8) {
                                    Text(user.username)
                                        .foregroundColor(.white)
                                        .font(.system(size: 36, weight: .bold))

                                    Text("Meditation Enthusiast")
                                        .foregroundColor(.white.opacity(0.7))
                                        .font(.title2)
                                }
                            }

                            // Stats Section
                            HStack(spacing: 80) {
                                VStack(spacing: 12) {
                                    Text("15")
                                        .foregroundColor(.white)
                                        .font(.system(size: 32, weight: .bold))
                                    Text("Days Streak")
                                        .foregroundColor(.white.opacity(0.7))
                                        .font(.title3)
                                }

                                Rectangle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 2, height: 60)

                                VStack(spacing: 12) {
                                    Text("42")
                                        .foregroundColor(.white)
                                        .font(.system(size: 32, weight: .bold))
                                    Text("Sessions")
                                        .foregroundColor(.white.opacity(0.7))
                                        .font(.title3)
                                }

                                Rectangle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 2, height: 60)

                                VStack(spacing: 12) {
                                    Text("8h 30m")
                                        .foregroundColor(.white)
                                        .font(.system(size: 32, weight: .bold))
                                    Text("Total Time")
                                        .foregroundColor(.white.opacity(0.7))
                                        .font(.title3)
                                }
                            }

                            // Menu Items Section - Two Column Layout
                            VStack(spacing: 40) {
                                // First Row
                                HStack(spacing: 30) {
                                    NavigationLink(destination: NotificationSettingsView()) {
                                        ProfileMenuItemIpad(
                                            icon: "bell.fill",
                                            title: "Notifications",
                                            subtitle: "Reminder settings"
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())

                                    NavigationLink(destination: MoodLogView()) {
                                        ProfileMenuItemIpad(
                                            icon: "clock.fill",
                                            title: "History",
                                            subtitle: "Previous sessions"
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }

                                // Second Row
                                HStack(spacing: 30) {
                                    NavigationLink(destination: Text("Help & Support View")) {
                                        ProfileMenuItemIpad(
                                            icon: "questionmark.circle.fill",
                                            title: "Help & Support",
                                            subtitle: "Get assistance"
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())

                                    NavigationLink(destination: AboutPhoneView()) {
                                        ProfileMenuItemIpad(
                                            icon: "info.circle.fill",
                                            title: "About",
                                            subtitle: "App information"
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 60)

                            // Sign Out Button
                            Button(action: {
                                session.logout()
                            }) {
                                HStack(spacing: 16) {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .font(.title2)
                                    Text("Sign Out")
                                        .font(.title2)
                                }
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                                .frame(maxWidth: 400)
                                .frame(height: 70)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.1))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.red.opacity(0.5), lineWidth: 2)
                                        )
                                )
                                .padding(.top, 30)
                            }
                            .buttonStyle(PlainButtonStyle())

                            Spacer(minLength: 80)
                        }
                        .padding(.horizontal, 40)
                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct ProfileMenuItemIpad: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 24) {
            Image(systemName: icon)
                .foregroundColor(.purple)
                .font(.system(size: 28))
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(subtitle)
                    .foregroundColor(.white.opacity(0.7))
                    .font(.title3)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.5))
                .font(.title3)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1.5)
                )
        )
    }
}

#Preview {
    ProfileIpadView()
        .environmentObject(SessionViewModel())
}
