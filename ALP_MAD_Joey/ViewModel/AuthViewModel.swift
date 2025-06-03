//
//  AuthViewModel.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class AuthViewModel {
    var currentUser: UserModel?
    
    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func register(username: String, password: String) throws {
        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { $0.username == username }
        )

        let existingUsers = try context.fetch(descriptor)

        guard existingUsers.isEmpty else {
            throw AuthError.usernameTaken
        }

        let newUser = UserModel(username: username, password: password)
        context.insert(newUser)
        try context.save()

        currentUser = newUser
    }

    func login(username: String, password: String) throws {
        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate { $0.username == username && $0.password == password }
        )

        let users = try context.fetch(descriptor)

        guard let user = users.first else {
            throw AuthError.invalidCredentials
        }

        currentUser = user
    }

    enum AuthError: Error, LocalizedError {
        case usernameTaken
        case invalidCredentials

        var errorDescription: String? {
            switch self {
            case .usernameTaken:
                return "Username is already taken."
            case .invalidCredentials:
                return "Invalid username or password."
            }
        }
    }
}
