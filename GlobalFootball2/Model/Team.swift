//
//  Team.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/10/22.
//

import Foundation

struct Team: Identifiable, Decodable, Hashable {
    let id: Int
    let location: String
    let nationality: Int
    let wins: Int
    let losses: Int
    let leagueID: Int
    let reputation: Int
    let pointsFor: Int
    let pointsAgainst: Int
    let curSalary: Int
    let salaryBudget: Int
    let transferBudget: Int
    let primaryR: Int
    let primaryG: Int
    let primaryB: Int
    let secondaryR: Int
    let secondaryG: Int
    let secondaryB: Int

}

struct TeamResponse: Decodable {
    let request: [Team]
}
