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
