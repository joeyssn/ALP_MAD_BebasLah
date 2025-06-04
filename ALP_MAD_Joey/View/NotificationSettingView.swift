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
    @Environment(\.presentationMode) private var presentationMode

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
                            .font(.title2)
                    }

                    Spacer()

                    Text("Notifications")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.semibold)

                    Spacer()

                    Spacer().frame(width: 28) // Placeholder for symmetry
                }
                .padding(.horizontal)
                .padding(.top, 50)
                .padding(.bottom, 30)

                VStack(spacing: 20) {
                    Toggle(isOn: $reminderEnabled) {
                        Text("Enable Daily Reminder")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .purple))

                    if reminderEnabled {
                        VStack(spacing: 10) {
                            Text("Reminder Time")
                                .foregroundColor(.white)

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
                                .colorScheme(.dark) // ✅ Ensures white text and wheels
                        }

                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                )
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    NotificationSettingsView()
}
