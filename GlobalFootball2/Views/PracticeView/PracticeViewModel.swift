//
//  PracticeViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/5/22.
//

import Foundation

final class PracticeViewModel: ObservableObject {
    //0 is run play, 1 is pass play, 2 is kicking, 3 is punting
    @Published var practice : Int = 0
    @Published var practiceTypes = ["Pass Play", "Run Play", "Team Workout", "Special Teams"]
    @Published var thisTeamPlayers : [Player] = []
    @Published var sortedTeamPlayers : [Player] = []
    //@Binding var sortingVar : String = "throwAccuracyBoost"
    
    //switch(sortingVar
    func sortingVarChanged(thisNewVar: String) {
        sortedTeamPlayers = []
        switch(thisNewVar) {
        case "throwAccuracyBoost":
            sortedTeamPlayers = thisTeamPlayers.sorted(by: {$0.throwAccuracyBoost > $1.throwAccuracyBoost})
        case "evasionBoost":
            sortedTeamPlayers = thisTeamPlayers.sorted(by: {$0.evasionBoost > $1.evasionBoost})
        case "ballSecurityBoost":
            sortedTeamPlayers = thisTeamPlayers.sorted(by: {$0.ballSecurityBoost > $1.ballSecurityBoost})
        case "routeRunningBoost":
            sortedTeamPlayers = thisTeamPlayers.sorted(by: {$0.routeRunningBoost > $1.routeRunningBoost})
        case "catchingBoost":
            sortedTeamPlayers = thisTeamPlayers.sorted(by: {$0.catchingBoost > $1.catchingBoost})
        case "passBlockBoost":
            sortedTeamPlayers = thisTeamPlayers.sorted(by: {$0.passBlockBoost > $1.passBlockBoost})
        case "runBlockBoost":
            sortedTeamPlayers = thisTeamPlayers.sorted(by: {$0.runBlockBoost > $1.runBlockBoost})
        case "passRushingBoost":
            sortedTeamPlayers = thisTeamPlayers.sorted(by: {$0.passRushingBoost > $1.passRushingBoost})
        case "runStoppingBoost":
            sortedTeamPlayers = thisTeamPlayers.sorted(by: {$0.runStoppingBoost > $1.runStoppingBoost})
        case "tacklingBoost":
            sortedTeamPlayers = thisTeamPlayers.sorted(by: {$0.tacklingBoost > $1.tacklingBoost})
        case "coverageBoost":
            sortedTeamPlayers = thisTeamPlayers.sorted(by: {$0.coverageBoost > $1.coverageBoost})
        default:
            sortedTeamPlayers = thisTeamPlayers.sorted(by: {$0.throwAccuracyBoost > $1.throwAccuracyBoost})
        }
    }
    
    func getThisBoost(thisPlayer: Player, thisBoost: String) -> Int {
        var returnVal = 0
        switch(thisBoost) {
        case "throwAccuracyBoost":
            returnVal = thisPlayer.throwAccuracyBoost
        case "evasionBoost":
            returnVal = thisPlayer.evasionBoost
        case "ballSecurityBoost":
            returnVal = thisPlayer.ballSecurityBoost
        case "routeRunningBoost":
            returnVal = thisPlayer.routeRunningBoost
        case "catchingBoost":
            returnVal = thisPlayer.catchingBoost
        case "passBlockBoost":
            returnVal = thisPlayer.passBlockBoost
        case "runBlockBoost":
            returnVal = thisPlayer.runBlockBoost
        case "passRushingBoost":
            returnVal = thisPlayer.passRushingBoost
        case "runStoppingBoost":
            returnVal = thisPlayer.runStoppingBoost
        case "tacklingBoost":
            returnVal = thisPlayer.tacklingBoost
        case "coverageBoost":
            returnVal = thisPlayer.coverageBoost
        default:
            returnVal = thisPlayer.throwAccuracyBoost
        }
        return min(returnVal, 100)
    }
}
