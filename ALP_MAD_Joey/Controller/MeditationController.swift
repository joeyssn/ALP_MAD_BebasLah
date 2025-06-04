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
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    
}
