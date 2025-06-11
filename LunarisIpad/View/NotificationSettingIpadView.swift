//
//  NotificationSettingIpadView.swift
//  ALP_MAD_Joey
//
//  Created by Calvin Laiman on 11/06/25.
//

import SwiftUI

struct NotificationSettingIpadView: View {
    @AppStorage("reminderEnabled") private var reminderEnabled = false
    @AppStorage("reminderTime") private var reminderTime = "08:00 AM"
    @Environment(\.presentationMode) private var presentationMode
    @State private var showPermissionAlert = false

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
                            .font(.title)
                    }

                    Spacer()

                    Text("Notifications")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .semibold))

                    Spacer()

                    Spacer().frame(width: 40)
                }
                .padding(.horizontal, 60)
                .padding(.top, 40)
                .padding(.bottom, 40)

                VStack(spacing: 30) {
                    Toggle(isOn: Binding(
                        get: { reminderEnabled },
                        set: { newValue in
                            if newValue {
                                NotificationController.shared.requestAuthorization { granted in
                                    if granted {
                                        reminderEnabled = true
                                        NotificationController.shared.scheduleDailyMeditationReminder(timeString: reminderTime)
                                    } else {
                                        print("Notification permission denied by user.")
                                        showPermissionAlert = true
                                        reminderEnabled = false
                                    }
                                }
                            } else {
                                reminderEnabled = false
                                NotificationController.shared.cancelMeditationReminder()
                            }
                        }
                    )) {
                        Text("Enable Daily Reminder")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.medium)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .purple))

                    if reminderEnabled {
                        VStack(spacing: 16) {
                            Text("Reminder Time")
                                .foregroundColor(.white)
                                .font(.headline)

                            DatePicker("",
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
                                        }),
                                       displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .datePickerStyle(WheelDatePickerStyle())
                                .colorScheme(.dark)
                                .frame(maxWidth: 300)
                        }
                    }
                }
                .padding(40)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.08))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                )
                .padding(.horizontal, 120)

                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onChange(of: reminderTime) { newTimeValue in
            if reminderEnabled {
                NotificationController.shared.scheduleDailyMeditationReminder(timeString: newTimeValue)
            }
        }
        .onAppear {
            if reminderEnabled {
                NotificationController.shared.requestAuthorization { granted in
                    if granted {
                        NotificationController.shared.scheduleDailyMeditationReminder(timeString: reminderTime)
                    } else {
                        DispatchQueue.main.async {
                            reminderEnabled = false
                        }
                    }
                }
            }
        }
        .alert("Permission Denied", isPresented: $showPermissionAlert) {
            Button("Open Settings", action: {
                if let url = URL(string: UIApplication.openSettingsURLString),
                   UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            })
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("To enable reminders, please allow notification permissions in your iPad's Settings app.")
        }
    }
}

#Preview {
    NotificationSettingIpadView()
}
