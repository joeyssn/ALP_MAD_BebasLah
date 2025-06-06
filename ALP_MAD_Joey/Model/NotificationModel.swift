//
//  NotificationModel.swift
//  ALP_MAD_Joey
//
//  Created by Calvin Laiman on 06/06/25.
//

import Foundation
import SwiftData

@Model
class NotificationModel {
    @Attribute(.unique) var id: UUID
    var isEnabled: Bool
    var reminderTime: String

    init(isEnabled: Bool = false, reminderTime: String = "08:00 AM") {
        self.id = UUID()
        self.isEnabled = isEnabled
        self.reminderTime = reminderTime
    }
}
