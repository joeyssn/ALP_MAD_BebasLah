import SwiftUI
import SwiftData

struct ProfileIpadView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var session: SessionViewModel
    @Environment(\.modelContext) private var context

    var body: some View {
        if let user = session.currentUser {
            GeometryReader { geometry in
                ZStack {
                    Image("Login")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()

                    VStack(spacing: 0) {
                        // Header
//                        HStack {
//                            Button(action: {
//                                dismiss()
//                            }) {
//                                Image(systemName: "chevron.left")
//                                    .foregroundColor(.white)
//                                    .font(.title2)
//                            }
//                            .buttonStyle(PlainButtonStyle())
//
//                            Spacer()
//
//                            Text("Profile")
//                                .foregroundColor(.white)
//                                .font(.title2)
//                                .fontWeight(.semibold)
//
//                            Spacer()
//                        }
//                        .padding(.horizontal, 20)
//                        .padding(.top, max(20, geometry.safeAreaInsets.top))
//                        .padding(.bottom, 20)
//                        .frame(height: 60)

                        ScrollView {
                            VStack(spacing: 25) {
                                // Avatar and User Info
                                VStack(spacing: 16) {
                                    ZStack {
                                        Circle()
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.purple, Color.blue]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .frame(width: 100, height: 100)

                                        Image(systemName: "person.fill")
                                            .font(.system(size: 40))
                                            .foregroundColor(.white)
                                    }

                                    VStack(spacing: 4) {
                                        Text(user.username)
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .fontWeight(.bold)

                                        Text("Meditation Enthusiast")
                                            .foregroundColor(.white.opacity(0.7))
                                            .font(.subheadline)
                                    }
                                }
                                .padding(.top, 10)

                                // Stats
                                HStack(spacing: 20) {
                                    statBox(title: "15", subtitle: "Days Streak")
                                    divider()
                                    statBox(title: "42", subtitle: "Sessions")
                                    divider()
                                    statBox(title: "8h 30m", subtitle: "Total Time")
                                }
                                .padding(.horizontal, 20)

                                // Menu List
                                VStack(spacing: 15) {
                                    VStack(spacing: 12) {
                                        NavigationLink(destination: NotificationSettingIpadView()) {
                                            ProfileMenuItem(
                                                icon: "bell.fill",
                                                title: "Notifications",
                                                subtitle: "Reminder settings"
                                            )
                                        }
                                        .buttonStyle(PlainButtonStyle())

                                        NavigationLink(destination: MoodLogIpadView()
                                            .environmentObject(session)
                                            .environmentObject(MoodViewModel(context: context))) {
                                            ProfileMenuItem(
                                                icon: "clock.fill",
                                                title: "History",
                                                subtitle: "Previous sessions"
                                            )
                                        }
                                        .buttonStyle(PlainButtonStyle())

                                        NavigationLink(destination: Text("Help & Support View")) {
                                            ProfileMenuItem(
                                                icon: "questionmark.circle.fill",
                                                title: "Help & Support",
                                                subtitle: "Get assistance"
                                            )
                                        }
                                        .buttonStyle(PlainButtonStyle())

                                        NavigationLink(destination: AboutPhoneIpadView()) {
                                            ProfileMenuItem(
                                                icon: "info.circle.fill",
                                                title: "About",
                                                subtitle: "App information"
                                            )
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                    .padding(.horizontal, 20)

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
                                        .padding(.horizontal, 20)
                                        .padding(.top, 10)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                
                                // Bottom spacing
                                Color.clear
                                    .frame(height: max(50, geometry.safeAreaInsets.bottom + 20))
                            }
                            .padding(.vertical, 15)
                        }
                    }
                }
            }
        }
    }

    private func statBox(title: String, subtitle: String) -> some View {
        VStack(spacing: 6) {
            Text(title)
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.bold)
            Text(subtitle)
                .foregroundColor(.white.opacity(0.7))
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }

    private func divider() -> some View {
        Rectangle()
            .fill(Color.white.opacity(0.3))
            .frame(width: 1, height: 35)
    }

    struct ProfileMenuItem: View {
        let icon: String
        let title: String
        let subtitle: String

        var body: some View {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .foregroundColor(.purple)
                    .font(.title3)
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
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
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
    let controller = SessionViewModel()
    controller.currentUser = UserModel(userId: 1, username: "Joey", password: "123")
    
    let context = try! ModelContainer(for: UserModel.self, MoodModel.self).mainContext
    
    return NavigationStack {
        ProfileIpadView()
            .environmentObject(controller)
            .environment(\.modelContext, context)
    }
}
