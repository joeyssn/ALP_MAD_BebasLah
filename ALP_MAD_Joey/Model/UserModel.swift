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
    @Relationship var meditation: [MeditateSessionModel] = []
    
    init(userId: Int, username: String, password: String) {
        self.userId = userId
        self.username = username
        self.password = password
    }
}
