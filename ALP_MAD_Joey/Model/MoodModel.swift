//
//  MoodModel.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import Foundation

struct MoodModel: Identifiable, Codable {
    var id = UUID()
    var moodName: String
    var moodIcon: String
}

