//
//  Practice.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/9/22.
//

import Foundation

struct IndividualPractice: Codable, Hashable {
    let playerID: Int
    let practiceID: String
    let practicePosition: Int
    let teamID: Int
}

struct IndividualPracticeResponse: Codable {
    let request: [IndividualPractice]
}
