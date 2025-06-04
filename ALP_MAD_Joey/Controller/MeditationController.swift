//
//  MeditationController.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 04/06/25.
//

import Foundation
import SwiftData

@MainActor
class MeditationController: ObservableObject {
    let modelContext: ModelContext

//    @Published var cards: [MeditationCardModel] = []
//    @Published var likedCards: [MeditationCardModel] = []

    init(context: ModelContext) {
        self.modelContext = context
//        loadCards()
//        loadLikedCards()
    }

//    func loadCards() {
//        do {
//            let fetchDescriptor = FetchDescriptor<MeditationCardModel>()
//            cards = try modelContext.fetch(fetchDescriptor)
//        } catch {
//            print("Failed to fetch cards: \(error)")
//            cards = []
//        }
//    }
//
//    func loadLikedCards() {
//        do {
//            let fetchDescriptor = FetchDescriptor<MeditationCardModel>(
//                predicate: #Predicate<MeditationCardModel> { $0.isFavorite == true }
//            )
//            likedCards = try modelContext.fetch(fetchDescriptor)
//        } catch {
//            print("Failed to fetch liked cards: \(error)")
//            likedCards = []
//        }
//    }
//
//    func toggleFavorite(for card: MeditationCardModel) {
//        card.isFavorite.toggle()
//        do {
//            try modelContext.save()
//            loadCards()
//            loadLikedCards()
//        } catch {
//            print("Failed to save favorite status: \(error)")
//        }
//    }
}
