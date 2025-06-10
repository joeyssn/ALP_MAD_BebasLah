//
//  MeditationCardModel.swift
//  ALP_MAD_Joey
//
//  Created by Calvin Laiman on 02/06/25.
//

import Foundation
import SwiftData

@Model
class MeditationCardModel {
    @Attribute(.unique) var meditationCardId: Int
    var imageName: String
    var title: String
    var med_description: String
    var isFavorite: Bool = false
    
    @Relationship var meditationSession: MeditateSessionModel?
    
    init(meditationCardId: Int, imageName: String, title: String, med_description: String) {
        self.meditationCardId = meditationCardId
        self.imageName = imageName
        self.title = title
        self.med_description = med_description
    }
}

// MARK: - WatchConnectivity Support
extension MeditationCardModel: WatchTransferable {
    var dictionaryRepresentation: [String: Any] {
        var dict: [String: Any] = [
            "meditationCardId": meditationCardId,
            "imageName": imageName,
            "title": title,
            "med_description": med_description,
            "isFavorite": isFavorite
        ]

        if let session = meditationSession {
            dict["meditationSession"] = [
                "meditationSessionId": session.meditationSessionId ?? -1,
                "date": session.date.timeIntervalSince1970,
                "soundFile": session.soundFile,
                "duration": session.duration,
                "startTime": session.startTime,
                "endTime": session.endTime
            ]
        }

        return dict
    }
}
