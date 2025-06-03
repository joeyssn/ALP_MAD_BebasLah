//
//  UserModel.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import Foundation
import SwiftData

@Model
class UserModel {
    var id: UUID
    var username: String
    var password: String

    init(id: UUID = UUID(), username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
}
