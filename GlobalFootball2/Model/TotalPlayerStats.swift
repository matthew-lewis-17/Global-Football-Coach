//
//  TotalPlayerStats.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/4/22.
//

import Foundation

struct TotalPlayerStats: Codable, Hashable {
    let playerID: Int
    let gamesPlayed: Int
    let totalComps: Int
    let totalAttempts: Int
    let totalPassYards: Int
    let totalPassTDs: Int
    let totalPassInts: Int
    let totalCarries: Int
    let totalRushYards: Int
    let totalRushTDs: Int
    let totalFumbles: Int
    let totalCatches: Int
    let totalRecYards: Int
    let totalRecTDs: Int
    let totalTackles: Int
    let totalForcedFumbles: Int
    let totalRecoveredFumbles: Int
    let totalSacks: Int
    let totalInterceptions: Int
    let totalFgAttempts: Int
    let totalFgMade: Int
    let totalPuntAttempts: Int
    let totalPuntYards: Int
    let leagueID: Int
}

struct TotalPlayerStatsResponse: Codable {
    let request: [TotalPlayerStats]
}
