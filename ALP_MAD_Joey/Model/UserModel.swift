//
//  UserModel.swift
//  ALP_MAD_Joey
//
//  Created by student on 22/05/25.
//

import Foundation


struct UserModel: Identifiable, Codable {
    var id: UUID()
    var userbane: String
    var password: String
}
