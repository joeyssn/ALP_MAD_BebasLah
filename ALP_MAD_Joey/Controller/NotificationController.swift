//
//  NotificationController.swift
//  ALP_MAD_Joey
//
//  Created by Kevin Christian on 04/06/25.
//

import UserNotifications
import SwiftUI // Required for DateFormatter, though can be isolated

class NotificationController: ObservableObject {
    static let shared = NotificationController() 
    public static let dailyMeditationReminderIdentifier = "dailyMeditationReminder"

    private init() {}

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    func scheduleDailyMeditationReminder(timeString: String, title: String = "Time to Meditate 🧘 ", body: String = "Take a moment for yourself and find your inner peace.") {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                print("Notification permissions not granted. Cannot schedule reminder.")
                return
            }

            self.cancelMeditationReminder()

            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            guard let date = formatter.date(from: timeString) else {
                print("Error: Could not parse reminderTime for notification: \(timeString)")
                return
            }

            let calendar = Calendar.current
            var dateComponents = DateComponents()
            dateComponents.hour = calendar.component(.hour, from: date)
            dateComponents.minute = calendar.component(.minute, from: date)

            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = UNNotificationSound.default

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            // Use the static identifier from NotificationController
            let request = UNNotificationRequest(identifier: NotificationController.dailyMeditationReminderIdentifier,
                                                content: content,
                                                trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    let hour = dateComponents.hour ?? 0
                    let minute = dateComponents.minute ?? 0
                    print("Daily meditation reminder successfully scheduled for \(String(format: "%02d:%02d", hour, minute))")
                }
            }
        }
    }

    func cancelMeditationReminder() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [NotificationController.dailyMeditationReminderIdentifier])
        print("Cancelled any pending meditation reminders.")
    }

    func isReminderScheduled(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            // Use the static identifier from NotificationController
            let isScheduled = requests.contains { $0.identifier == NotificationController.dailyMeditationReminderIdentifier }
            DispatchQueue.main.async {
                completion(isScheduled)
            }
        }
    }
}
