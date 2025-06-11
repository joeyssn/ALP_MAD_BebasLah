//
//  NotificationSettingView.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 03/06/25.
//

import SwiftUI

struct NotificationSettingsView: View {
    @AppStorage("reminderEnabled") private var reminderEnabled = false
    @AppStorage("reminderTime") private var reminderTime = "08:00 AM"
    @Environment(\.dismiss) private var dismiss
    @State private var showPermissionAlert = false

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
//                    Text("Notifications")
//                        .foregroundColor(.white)
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                    
//                    Spacer()
//                    
//                    // Balance spacer
//                    Color.clear
//                        .frame(width: 28, height: 28)
//                }
//                .padding(.horizontal, 24)
//                .padding(.top, 20)
//                .padding(.bottom, 16)

                // Scrollable content with proper constraints
                ScrollView {
                    VStack(spacing: 24) {
                        // Main toggle section
                        VStack(spacing: 20) {
                            Toggle(isOn: Binding(
                                get: { reminderEnabled },
                                set: { newValue in
                                    if newValue {
                                        NotificationController.shared.requestAuthorization { granted in
                                            DispatchQueue.main.async {
                                                if granted {
                                                    reminderEnabled = true
                                                    NotificationController.shared.scheduleDailyMeditationReminder(timeString: reminderTime)
                                                } else {
                                                    print("Notification permission denied by user.")
                                                    showPermissionAlert = true
                                                    reminderEnabled = false
                                                }
                                            }
                                        }
                                    } else {
                                        reminderEnabled = false
                                        NotificationController.shared.cancelMeditationReminder()
                                    }
                                }
                            )) {
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
                                Divider()
                                    .background(Color.white.opacity(0.3))
                                
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
                                            selection: Binding(
                                                get: {
                                                    let formatter = DateFormatter()
                                                    formatter.dateFormat = "hh:mm a"
                                                    return formatter.date(from: reminderTime) ?? Date()
                                                },
                                                set: { newDate in
                                                    let formatter = DateFormatter()
                                                    formatter.dateFormat = "hh:mm a"
                                                    reminderTime = formatter.string(from: newDate)
                                                }
                                            ),
                                            displayedComponents: .hourAndMinute
                                        )
                                        .labelsHidden()
                                        .datePickerStyle(.field) // Better for macOS
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
                        
                        // Additional info section
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
                    .frame(maxWidth: 600) // Constrain maximum width for better readability
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(minWidth: 500, minHeight: 600) // Better minimum size for macOS
        .background(Color.clear)
        .onChange(of: reminderTime) { newTimeValue in
            if reminderEnabled {
                print("Reminder time changed to \(newTimeValue), rescheduling...")
                NotificationController.shared.scheduleDailyMeditationReminder(timeString: newTimeValue)
            }
        }
        .onAppear {
            if reminderEnabled {
                NotificationController.shared.requestAuthorization { granted in
                    DispatchQueue.main.async {
                        if granted {
                            NotificationController.shared.scheduleDailyMeditationReminder(timeString: reminderTime)
                        } else {
                            reminderEnabled = false
                        }
                    }
                }
            }
        }
        .alert("Permission Denied", isPresented: $showPermissionAlert) {
            Button("Open System Preferences", action: {
                if let url = URL(string: "x-apple.systempreferences:com.apple.preference.notifications") {
                    NSWorkspace.shared.open(url)
                }
            })
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("To enable reminders, please allow notification permissions in System Preferences.")
        }
    }
}

#Preview {
    NotificationSettingsView()
        .frame(width: 600, height: 700)
}
