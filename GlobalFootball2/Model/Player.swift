//
//  Player.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/9/22.
//

import Foundation

struct Player: Identifiable, Codable, Hashable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let teamID: Int
    let loanTeamID: Int
    let nationality: Int
    let position: Int
    let leagueID: Int
    let overall: Int
    let speed: Int
    let agility: Int
    let strength: Int
    let oAwareness: Int
    let dAwareness: Int
    let catching: Int
    let ballSecurity: Int
    let throwPower: Int
    let throwAccuracy: Int
    let kickPower: Int
    let kickAccuracy: Int
    let puntPower: Int
    let puntAccuracy: Int
    let runBlock: Int
    let passBlock: Int
    let tackling: Int
    let coverage: Int
    let passRushing: Int
    let runStopping: Int
    let routeRunning: Int
    let evasion: Int
    let agilityBoost: Int
    let strengthBoost: Int
    let catchingBoost: Int
    let ballSecurityBoost: Int
    let throwAccuracyBoost: Int
    let kickPowerBoost: Int
    let kickAccuracyBoost: Int
    let puntPowerBoost: Int
    let puntAccuracyBoost: Int
    let runBlockBoost: Int
    let passBlockBoost: Int
    let tacklingBoost: Int
    let coverageBoost: Int
    let passRushingBoost: Int
    let runStoppingBoost: Int
    let routeRunningBoost: Int
    let evasionBoost: Int
    let potential: Int
    let remYearsContract: Int
    let salaryContract: Int
    var depthChartPosition:Int
    let condition: Int
    let daysOnMarket: Int
    
    func getPhysicalRatings() -> [[String]] {
        return [["Speed", String(self.speed)], ["Strength", String(self.strength)], ["Agility", String(self.agility)]]
    }
    
    func getRatings() -> [[String]] {
        var retList:[[String]] = []
        //if QB
        switch self.position {
        case 1:
            retList.append(["Arm Strength", String(self.throwPower)])
            retList.append(["Pass Accuracy", String(self.throwAccuracy)])
            retList.append(["Juking", String(self.evasion)])
            retList.append(["Ball Security", String(self.ballSecurity)])
            retList.append(["Offensive Awareness", String(self.oAwareness)])
        case 2:
            retList.append(["Juking", String(self.evasion)])
            retList.append(["Ball Security", String(self.ballSecurity)])
            retList.append(["Catching", String(self.catching)])
            retList.append(["Route Running", String(self.routeRunning)])
            retList.append(["Pass Blocking", String(self.passBlock)])
            retList.append(["Offensive Awareness", String(self.oAwareness)])
        case 3:
            retList.append(["Catching", String(self.catching)])
            retList.append(["Route Running", String(self.routeRunning)])
            retList.append(["Juking", String(self.evasion)])
            retList.append(["Ball Security", String(self.ballSecurity)])
            retList.append(["Offensive Awareness", String(self.oAwareness)])
        case 4:
            retList.append(["Run Blocking", String(self.runBlock)])
            retList.append(["Pass Blocking", String(self.passBlock)])
            retList.append(["Catching", String(self.catching)])
            retList.append(["Route Running", String(self.routeRunning)])
            retList.append(["Juking", String(self.evasion)])
            retList.append(["Ball Security", String(self.ballSecurity)])
            retList.append(["Offensive Awareness", String(self.oAwareness)])
        case 5:
            retList.append(["Run Blocking", String(self.runBlock)])
            retList.append(["Pass Blocking", String(self.passBlock)])
            retList.append(["Offensive Awareness", String(self.oAwareness)])
        case 6:
            retList.append(["Run Blocking", String(self.runBlock)])
            retList.append(["Pass Blocking", String(self.passBlock)])
            retList.append(["Offensive Awareness", String(self.oAwareness)])
        case 7:
            retList.append(["Run Blocking", String(self.runBlock)])
            retList.append(["Pass Blocking", String(self.passBlock)])
            retList.append(["Offensive Awareness", String(self.oAwareness)])
        case 8:
            retList.append(["Run Stopping", String(self.runStopping)])
            retList.append(["Pass Rushing", String(self.passRushing)])
            retList.append(["Tackling", String(self.tackling)])
            retList.append(["Defensive Awareness", String(self.dAwareness)])
        case 9:
            retList.append(["Run Stopping", String(self.runStopping)])
            retList.append(["Pass Rushing", String(self.passRushing)])
            retList.append(["Tackling", String(self.tackling)])
            retList.append(["Defensive Awareness", String(self.dAwareness)])
        case 10:
            retList.append(["Run Stopping", String(self.runStopping)])
            retList.append(["Pass Rushing", String(self.passRushing)])
            retList.append(["Tackling", String(self.tackling)])
            retList.append(["Coverage", String(self.coverage)])
            retList.append(["Defensive Awareness", String(self.dAwareness)])
        case 11:
            retList.append(["Run Stopping", String(self.runStopping)])
            retList.append(["Pass Rushing", String(self.passRushing)])
            retList.append(["Tackling", String(self.tackling)])
            retList.append(["Coverage", String(self.coverage)])
            retList.append(["Defensive Awareness", String(self.dAwareness)])
        case 12:
            retList.append(["Run Stopping", String(self.runStopping)])
            retList.append(["Pass Rushing", String(self.passRushing)])
            retList.append(["Tackling", String(self.tackling)])
            retList.append(["Coverage", String(self.coverage)])
            retList.append(["Defensive Awareness", String(self.dAwareness)])
        case 13:
            retList.append(["Coverage", String(self.coverage)])
            retList.append(["Tackling", String(self.tackling)])
            retList.append(["Catching", String(self.catching)])
            retList.append(["Defensive Awareness", String(self.dAwareness)])
        case 14:
            retList.append(["Coverage", String(self.coverage)])
            retList.append(["Tackling", String(self.tackling)])
            retList.append(["Catching", String(self.catching)])
            retList.append(["Defensive Awareness", String(self.dAwareness)])
        case 15:
            retList.append(["Kick Power", String(self.kickPower)])
            retList.append(["Kick Accuracy", String(self.kickAccuracy)])
        case 16:
            retList.append(["Punt Power", String(self.puntPower)])
            retList.append(["Punt Accuracy", String(self.puntAccuracy)])
        default:
            retList.append(["error getting ratings"])
        }
        return retList
    }
}

struct PlayerResponse: Codable {
    let request: [Player]
}
