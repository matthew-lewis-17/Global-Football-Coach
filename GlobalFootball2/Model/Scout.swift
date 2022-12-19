//
//  Scout.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/1/22.
//

import Foundation

struct Scout: Codable {
    let playerID: Int
    let coachID: Int
    let year: Int
}

struct ScoutResponse: Codable {
    let request: [Scout]
}
