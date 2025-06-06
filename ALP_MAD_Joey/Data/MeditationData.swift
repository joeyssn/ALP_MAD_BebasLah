//
//  MeditationData.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 05/06/25.
//

import Foundation

struct MeditationData {
    static let meditationCards = [
        MeditationCardModel(meditationCardId: 1, imageName: "gambar1", title: "Moonlight Mind", med_description: "A calming nighttime practice to release the day and embrace rest."),
        MeditationCardModel(meditationCardId: 2, imageName: "gambar2", title: "The Quiet Within", med_description: "An introspective meditation to listen to the wisdom of your inner self."),
        MeditationCardModel(meditationCardId: 3, imageName: "gambar3", title: "Ocean Waves", med_description: "Let the rhythm of waves guide you to peaceful tranquility."),
        MeditationCardModel(meditationCardId: 4, imageName: "gambar4", title: "Mountain Serenity", med_description: "Find stability and strength in mountain meditation."),
        MeditationCardModel(meditationCardId: 5, imageName: "gambar5", title: "Mountain Meditating", med_description: "Bertapa digunung"),
        MeditationCardModel(meditationCardId: 6, imageName: "gambar6", title: "Stanley Young", med_description: "I'm gay")
    ]

    static func meditationSessions() -> [MeditateSessionModel] {
        let soundFiles = [
            "Don't Listen to Them",
            "Kiss The Rain",
            "River Flows In You",
            "Love Me",
            "Ada Nona Ambon Ga Disini",
            "Young Gay"
        ]

        return soundFiles.enumerated().compactMap { index, soundFile in
            let durationSeconds = SoundManager.shared.getDuration(of: soundFile)
            let duration = Int(durationSeconds)
            return MeditateSessionModel(
                meditationSessionId: index + 1,
                date: Date(),
                soundFile: soundFile,
                duration: duration,
                startTime: 0,
                endTime: duration
            )
        }
    }
}
