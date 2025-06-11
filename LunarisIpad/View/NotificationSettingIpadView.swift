import SwiftUI
//import UserNotifications

struct NotificationSettingIpadView: View {
    @AppStorage("reminderEnabled") private var reminderEnabled = false
    @AppStorage("reminderTime") private var reminderTime: String = "08:00 AM"
    @AppStorage("username") private var username: String = "User"
    
    @Environment(\.dismiss) private var dismiss
    @State private var showPermissionAlert = false
    @State private var selectedTime: Date = Date()

    private static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }
    
    // Extract the complex binding into a computed property
    private var reminderBinding: Binding<Bool> {
        Binding(
            get: { reminderEnabled },
            set: { newValue in
                handleReminderToggle(newValue)
            }
        )
    }
    
    // Extract the toggle logic into a separate method
    private func handleReminderToggle(_ newValue: Bool) {
        if newValue {
            NotificationViewModel.shared.requestPermission { granted in
                DispatchQueue.main.async {
                    if granted {
                        reminderEnabled = true
                        NotificationViewModel.shared.scheduleDailyNotification(at: reminderTime, for: username)
                    } else {
                        showPermissionAlert = true
                        reminderEnabled = false
                    }
                }
            }
        } else {
            reminderEnabled = false
            NotificationViewModel.shared.cancelNotification()
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("Login")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
            .ignoresSafeArea()

            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 20) {
                            Toggle(isOn: reminderBinding) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Enable Daily Reminder")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .fontWeight(.medium)

                                        Text("Get reminded to meditate daily")
                                            .foregroundColor(.white.opacity(0.7))
                                            .font(.subheadline)
                                    }
                                    Spacer(minLength: 16)
                                }
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .purple))

                            if reminderEnabled {
                                Divider().background(Color.white.opacity(0.3))
                                
                                VStack(spacing: 16) {
                                    HStack {
                                        Text("Reminder Time")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .fontWeight(.medium)
                                        Spacer()
                                    }

                                    HStack {
                                        DatePicker(
                                            "Select time",
                                            selection: $selectedTime,
                                            displayedComponents: .hourAndMinute
                                        )
                                        .labelsHidden()
                                        .datePickerStyle(.compact)
                                        .accentColor(.purple)
                                        .frame(maxWidth: 120)
                                        
                                        Spacer()
                                    }
                                }
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

                        if reminderEnabled {
                            HStack(alignment: .top, spacing: 16) {
                                Image(systemName: "info.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.title3)
                                    .frame(width: 24, height: 24)

                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Notification Info")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .fontWeight(.medium)

                                    Text("You'll receive a daily reminder at \(reminderTime) to practice meditation.")
                                        .foregroundColor(.white.opacity(0.8))
                                        .font(.subheadline)
                                        .fixedSize(horizontal: false, vertical: true)
                                }

                                Spacer()
                            }
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.blue.opacity(0.1))
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                    )
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)
                    .frame(maxWidth: 600)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            selectedTime = Self.timeFormatter.date(from: reminderTime) ?? Date()
            if reminderEnabled {
                NotificationViewModel.shared.requestPermission { granted in
                    DispatchQueue.main.async {
                        if granted {
                            NotificationViewModel.shared.scheduleDailyNotification(at: reminderTime, for: username)
                        } else {
                            reminderEnabled = false
                        }
                    }
                }
            }
        }
        .onChange(of: selectedTime) { newDate in
            reminderTime = Self.timeFormatter.string(from: newDate)
            if reminderEnabled {
                NotificationViewModel.shared.scheduleDailyNotification(at: reminderTime, for: username)
            }
        }
        .alert("Permission Denied", isPresented: $showPermissionAlert) {
            Button("Open Settings", action: {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            })
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("To enable reminders, please allow notification permissions in Settings.")
        }
    }
}

#Preview {
    NotificationSettingIpadView()
        .frame(width: 600, height: 700)
}
