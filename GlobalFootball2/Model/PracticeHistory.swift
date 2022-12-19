//
//  PracticeHistory.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/9/22.
//

import Foundation

struct PracticeHistory: Codable, Hashable {
    let practiceID : String
    let practiceType : String
    let teamID : Int
    let week: Int
}

struct PracticeHistoryResponse: Codable {
    let request: [PracticeHistory]
}
