//
//  SecondsToMinutes.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/27/22.
//

import Foundation
import SwiftUI

func secondsToMinutes(numSeconds: Int) -> String {
    let numMinutes:Int = Int(floor(Double(numSeconds) / 60))
    let newSeconds:Int = numSeconds % 60
    var secString:String
    if (newSeconds < 10) {
        secString = "0" + String(newSeconds)
    }
    else {
        secString = String(newSeconds)
    }
    return String(numMinutes) + ":" + secString
}

func getPlayerName(thisPlayer: Player) -> String {
    return thisPlayer.firstName.prefix(1) + ". " + thisPlayer.lastName
}
/*
func getRatingString(thisPlayer: Player, ratingsEntry:[String]) -> String {
    let mirror = Mirror(reflecting: self)
    for (key, value) in mirror.children {
        print("key: " + key!)
        //print("value: " + value )
    }
    return "error"
}
 */

func getTeamFromTeamID(teamID: Int, allTeams: [Team]) -> Team {
    for thisTeam in allTeams {
        if thisTeam.id == teamID {
            return thisTeam
        }
    }
    print("error getting team")
    return allTeams[0]
}

func determineBoosts(listOfIDs: [Int], thisPositionList: [Int], thisBoostMap : Dictionary<Int, [[Any]]>) -> [UpdateBoost] {
    var finalBoosts : [UpdateBoost] = []
    for i in 0..<listOfIDs.count {
        //let thisPlayer = loginViewModel.thisTeamPlayers[loginViewModel.thisTeamPlayers.firstIndex(where: {$0.id == thisIDList[i]})!]
        let thisPlayerID = listOfIDs[i]
        let thisRand = Int.random(in: 0...100)
        let thisBoost = Int.random(in: 4...6)
        var boostString = ""
        
        for j in thisBoostMap[thisPositionList[i], default: [[]]] {
            if thisRand <= j[0] as! Int {
                boostString = j[1] as! String
                finalBoosts.append(UpdateBoost(playerID: thisPlayerID, boostAmount: thisBoost, variableBoost: boostString))
                break
            }
        }
    }
    print(finalBoosts)
    return finalBoosts
}

func getPlayerFromID(playerId:Int, playerList:[Player]) -> Player {
    for thisPlayer in playerList {
        if (thisPlayer.id == playerId) {
            return thisPlayer
        }
    }
    print("error getting player")
    return playerList[0]
}

//decide whether to show view for player who is on your team or view for a player of another team
func decidePlayerView(thisPlayer: Player, userCoach: Coach) -> String {
    if thisPlayer.teamID == userCoach.teamID {
        return "team"
    }
    else {
        return "other"
    }
}

func decideTeamView(thisTeam: Team, userCoach: Coach) -> String {
    if thisTeam.id == userCoach.teamID {
        return "team"
    }
    else {
        return "other"
    }
}

func salaryToMillions(thisSalary: Int) -> String {
    //700k case
    if thisSalary < 1000000 {
        var manipulated : Double = Double(thisSalary) / 1000
        var moneyString : String = String(format: "%.2f", manipulated)
        return "$" + moneyString + "K"
    }
    else {
        var manipulated : Double = Double(thisSalary) / 1000000
        var moneyString : String = String(format: "%.2f", manipulated)
        return "$" + moneyString + "M"
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
