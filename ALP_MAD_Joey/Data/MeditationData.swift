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

    static let meditationSessions = [
        MeditateSessionModel(meditationSessionId: 1, date: Date(), soundFile: "Don't Listen to Them", duration: 1200, startTime: 0, endTime: 1200),
        MeditateSessionModel(meditationSessionId: 2, date: Date(), soundFile: "Kiss The Rain", duration: 1200, startTime: 0, endTime: 1200),
        MeditateSessionModel(meditationSessionId: 3, date: Date(), soundFile: "River Flows In You", duration: 1200, startTime: 0, endTime: 1200),
        MeditateSessionModel(meditationSessionId: 4, date: Date(), soundFile: "Love Me", duration: 1200, startTime: 0, endTime: 1200),
        MeditateSessionModel(meditationSessionId: 5, date: Date(), soundFile: "Ada Nona Ambon Ga Disini", duration: 1200, startTime: 0, endTime: 1200),
        MeditateSessionModel(meditationSessionId: 6, date: Date(), soundFile: "Young Gay", duration: 1200, startTime: 0, endTime: 1200)
    ]
    
}
