//
//  Schedule.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/26/22.
//

import Foundation

struct Schedule: Identifiable, Decodable, Hashable {    
    let id: Int
    let homeTeamID: Int
    let awayTeamID: Int
    let week: Int
    let timeSlot: Int
    let leagueID: Int
    let gameID: Int
    let curQuarter: Int
    let curTime: Int
    let curDown: Int
    let curDistance: Int
    let fieldPosition: Int
    let possession: Int
    let scoreHome: Int
    let scoreAway: Int
}

struct ScheduleResponse: Decodable {
    let request: [Schedule]
}

struct idRequestResponse : Decodable {
    let request: [Int]
}
