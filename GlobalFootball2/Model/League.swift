//
//  League.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/10/22.
//

import Foundation

struct League: Identifiable, Decodable, Hashable {
    let id: Int
    let nationality: Int
    let leagueName: String
    let tier: Int
    let numTeams: Int
    let numProm: Int
    let numRel: Int
    
}

struct LeagueResponse: Decodable {
    let request: [League]
}
