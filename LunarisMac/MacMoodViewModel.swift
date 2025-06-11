//
//  MoodController.swift
//  ALP_MAD_Joey
//
//  Created by Calvin Laiman on 04/06/25.
//

import Foundation
import SwiftData

class MoodController: ObservableObject {
    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func logMood(moodName: String, for userId: Int) throws {
        let newMood = MoodModel(moodName: moodName, userId: userId)
        context.insert(newMood)
        try context.save()
    }

    func getMoods(for userId: Int) throws -> [MoodModel] {
        let descriptor = FetchDescriptor<MoodModel>(
            predicate: #Predicate { $0.userId == userId },
            sortBy: [SortDescriptor(\.dateLogged, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }
}

