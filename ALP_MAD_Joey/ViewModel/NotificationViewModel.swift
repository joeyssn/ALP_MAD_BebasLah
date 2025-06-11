//
//  NotificationViewModel.swift
//  ALP_MAD_Joey
//
//  Created by Calvin Laiman on 06/06/25.
//

import Foundation
import UserNotifications

@MainActor
class NotificationViewModel: ObservableObject {
    
    let notificationMessages = [
        "Don't forget to take a deep breath today 🌿",
        "Your progress matters – keep going 💪",
        "A little mindfulness goes a long way 🧘",
        "How are you feeling today? Take a moment for yourself 💭",
        "Consistency is key! Let's do it 💥",
        "Remember: one small step is still a step 🚶‍♂️",
        "Your mind deserves a break – breathe now 😌",
        "Stay grounded. Stay grateful 🤍",
        "You’re doing better than you think ✨",
        "Time for a calm reset. You've got this ☀️"
    ]
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting permission: \(error.localizedDescription)")
            }
        }
    }

    func scheduleDailyNotification(at timeString: String, for username: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        guard let date = formatter.date(from: timeString) else {
            print("Invalid time format.")
            return
        }

        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

        let content = UNMutableNotificationContent()
        content.title = "Hi \(username) 👋"
        content.body = notificationMessages.randomElement() ?? "Don't forget your daily moment of peace."
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            }
        }
    }

    func cancelNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyReminder"])
    }
}
