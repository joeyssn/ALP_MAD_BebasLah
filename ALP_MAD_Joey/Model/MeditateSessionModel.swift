//
//  MeditateSessionModel.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import Foundation
import SwiftData

@Model
class MeditateSessionModel {
    @Attribute(.unique) var meditationSessionId: Int? = nil

    var date: Date
    var soundFile: String
    var duration: Int
    var startTime: Int
    var endTime: Int

    // Many-to-many with User
    @Relationship(inverse: \UserModel.meditation)
    var users: [UserModel] = []

    // One-to-one with MeditationCard
    @Relationship var meditationCard: MeditationCardModel?

    init(
        meditationSessionId: Int,
        date: Date,
        soundFile: String,
        duration: Int,
        startTime: Int,
        endTime: Int
    ) {
        self.meditationSessionId = meditationSessionId
        self.date = date
        self.soundFile = soundFile
        self.duration = duration
        self.startTime = startTime
        self.endTime = endTime
    }
}
