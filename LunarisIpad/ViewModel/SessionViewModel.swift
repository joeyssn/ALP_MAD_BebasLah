//
//  SessionController.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 04/06/25.
//

import Foundation
import SwiftData

@MainActor
class SessionViewModel: ObservableObject {
    @Published var currentUser: UserModel? = nil
    @Published var isLoggedIn: Bool = false

    func login(user: UserModel) {
        currentUser = user
        isLoggedIn = true
    }

    func logout() {
        currentUser = nil
        isLoggedIn = false
    }
}
