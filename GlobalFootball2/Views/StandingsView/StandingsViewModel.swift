//
//  StandingsViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/17/22.
//

import Foundation

final class StandingsViewModel: ObservableObject {
    func getThisNation(thisCoach: Coach, allTeams: [Team]) -> Int {
        for i in allTeams {
            if i.id == thisCoach.teamID {
                return i.nationality
            }
        }
        return -1
    }
    
    func getThisLeague(thisCoach: Coach, allTeams: [Team]) -> Int {
        for i in allTeams {
            if i.id == thisCoach.teamID {
                return i.leagueID
            }
        }
        return -1
    }
    
    func getTopLeague(newNation: Int, allLeagues: [League]) -> Int {
        var minLeagueID = 1000000
        for thisLeague in allLeagues {
            if thisLeague.nationality == newNation && thisLeague.id < minLeagueID {
                minLeagueID = thisLeague.id
            }
        }
        return minLeagueID
    }
}
