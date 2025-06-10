//
//  ReminderModel.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import Foundation

struct ReminderModel: Identifiable,Codable {
    var id = UUID()
    var userID = UUID()
    var time :  Int
    var isActive: Bool
    var reminderText: String
}

// MARK: - WatchConnectivity Support
extension ReminderModel: WatchTransferable {
    var dictionaryRepresentation: [String: Any] {
        return [
            "id": id.uuidString,
            "userID": userID.uuidString,
            "time": time,
            "isActive": isActive,
            "reminderText": reminderText
        ]
    }
}
