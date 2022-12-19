//
//  Coach.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/9/22.
//

import Foundation

struct Coach: Identifiable, Codable {
    let id: Int
    let userID: Int
    let username: String
    let firstname: String
    let lastname: String
    let age: Int
    let wins: Int
    let losses: Int
    let teamID: Int
    let defPoints: Int
    var curPoints: Int
    let reputation: Double
    var passFreq: Double
    var runFreq: Double
    var shortPassFreq:Double
    var mediumPassFreq:Double
    var longPassFreq:Double
    var qbRunFreq:Double
    var outsideRunFreq:Double
    var insideRunFreq:Double
    var stopRunFreq:Double
    var stopPassFreq:Double
    var baseDFreq:Double
    var aggressiveness:Int
    var timeManagement:Int
}

struct CoachResponse: Decodable {
    let request: [Coach]
}
