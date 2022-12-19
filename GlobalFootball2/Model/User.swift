//
//  User.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/9/22.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let username: String
    let coachID: Int
}

struct UserResponse: Decodable {
    let request: [User]
}
