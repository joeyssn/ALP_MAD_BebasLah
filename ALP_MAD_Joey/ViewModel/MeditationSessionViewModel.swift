//
//  MeditationSessionController.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 05/06/25.
//

import Foundation
import SwiftData

@MainActor
class MeditationSessionViewModel: ObservableObject {
    let modelContext: ModelContext

    init(context: ModelContext) {
        self.modelContext = context
    }

    func playSound(named soundFile: String) {
        SoundManager.shared.playImportedSound(named: soundFile)
    }

    func pauseSound() {
        SoundManager.shared.pause()
    }

    func resumeSound() {
        SoundManager.shared.resume()
    }

    func stopSound() {
        SoundManager.shared.stop()
    }
}


