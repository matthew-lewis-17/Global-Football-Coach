//
//  GameState.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/27/22.
//

import Foundation

struct GameState: Identifiable, Decodable {
    let gameID: Int
    let curQuarter: Int
    let curTime: Int
    let curDown: Int
    let curDistance: Int
    let fieldPosition: Int
    let lastPBP: String
    let possession: Int
    let scoreHome: Int
    let scoreAway: Int
    let id: Int
}

struct GameStateResponse: Decodable {
    let request: [GameState]
}
