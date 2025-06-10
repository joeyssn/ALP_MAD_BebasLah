//
//  UserModel.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import Foundation
import SwiftData

@Model
class UserModel {
    @Attribute(.unique) var userId: Int? = nil
    var username: String
    var password: String
    @Relationship var moods: [MoodModel] = []
    @Relationship var reminder: [ReminderModel] = []
    @Relationship var meditation: [MeditateSessionModel] = []
    
    init(userId: Int, username: String, password: String) {
        self.userId = userId
        self.username = username
        self.password = password
    }
}

// MARK: - WatchConnectivity Support
extension UserModel: WatchTransferable {
    var dictionaryRepresentation: [String: Any] {
        return [
            "userId": userId ?? -1, // Fallback if userId is nil
            "username": username,
            "password": password
        ]
    }
}
