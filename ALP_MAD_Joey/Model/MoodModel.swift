//
//  MoodModel.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import Foundation
import SwiftData

@Model
class MoodModel {
    var id: UUID
    var moodName: String
    var dateLogged: Date
    var userId: Int

    init(moodName: String, dateLogged: Date = .now, userId: Int) {
        self.id = UUID()
        self.moodName = moodName
        self.dateLogged = dateLogged
        self.userId = userId
    }
}

