//
//  MeditateSessionModel.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import Foundation

struct MeditateSessionModel: Identifiable, Codable {
    var id = UUID()
    var userID = UUID()
    var moodBeforeId: String
    var moodAfterId: String
    var date: Date
    var duration: Int
    var startTime: Int
    var endTime: Int
}
