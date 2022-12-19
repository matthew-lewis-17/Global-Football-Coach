//
//  Statline.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/27/22.
//

import Foundation

struct Statline: Identifiable, Decodable, Hashable {
    let gameID: Int
    let playerID: Int
    let passCompletions: Int
    let passAttempts: Int
    let passYards: Int
    let passTDs: Int
    let passInts: Int
    let carries: Int
    let rushYards: Int
    let rushTDs: Int
    let fumbles: Int
    let catches: Int
    let recYards: Int
    let recTDs: Int
    let tackles: Int
    let forcedFumbles: Int
    let recoveredFumbles: Int
    let sacks: Int
    let interceptions: Int
    let fgAttempts: Int
    let fgMade: Int
    let puntAttempts: Int
    let puntYards: Int
    //computed property to conform to identifiable protocol
    var id: UUID {
        return UUID()
    }
}

struct StatlineResponse: Decodable {
    let request: [Statline]
}
