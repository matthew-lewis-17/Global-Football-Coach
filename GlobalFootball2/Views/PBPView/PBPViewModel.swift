//
//  PBPViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/27/22.
//

import Foundation

final class PBPViewModel: ObservableObject {
    @Published var allTeams:[Team] = []
    @Published var homeTeam:Team = Team(id: -1, location: "err", nationality: -1, wins: -1, losses: -1, leagueID: -1, reputation: -1, pointsFor: -1, pointsAgainst: -1, curSalary: -1, salaryBudget:-1, transferBudget:-1, primaryR: -1, primaryG: -1, primaryB: -1, secondaryR: -1, secondaryG: -1, secondaryB: -1)
    @Published var awayTeam:Team = Team(id: -1, location: "err", nationality: -1, wins: -1, losses: -1, leagueID: -1, reputation: -1, pointsFor: -1, pointsAgainst: -1, curSalary: -1, salaryBudget:-1, transferBudget:-1, primaryR: -1, primaryG: -1, primaryB: -1, secondaryR: -1, secondaryG: -1, secondaryB: -1)
    @Published var gameID:Int = -1
    @Published var gameStates:[GameState] = []
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    @Published var lastState:GameState =  GameState(gameID: -1, curQuarter: -1, curTime: -1, curDown: -1, curDistance: -1, fieldPosition: -1, lastPBP: "", possession: -1, scoreHome: -1, scoreAway: -1, id:-1)
    @Published var thisStatline:[Statline] = []
    @Published var allPlayers:[Player] = []
    @Published var PBPViewVar = "stats"
    @Published var PBPPicker = ["stats", "fullPBP"]
    
    
    func getPassers() -> [Statline] {
        var passers:[Statline] = []
        for thisLine in thisStatline {
            if thisLine.passAttempts > 0 {
                passers.append(thisLine)
            }
        }
        return passers
    }
    
    func getRushers() -> [Statline] {
        var rushers:[Statline] = []
        for thisLine in thisStatline {
            if thisLine.carries > 0 {
                rushers.append(thisLine)
            }
        }
        return rushers
    }
    
    func getReceivers() -> [Statline] {
        var receivers:[Statline] = []
        for thisLine in thisStatline {
            if thisLine.catches > 0 {
                receivers.append(thisLine)
            }
        }
        return receivers
    }
    
    func getDefenders() -> [Statline] {
        var defenders:[Statline] = []
        for thisLine in thisStatline {
            if thisLine.tackles > 0 || thisLine.interceptions > 0 {
                defenders.append(thisLine)
            }
        }
        return defenders
    }
    
    func getTeamIDs() {
        isLoading = true
        NetworkManager.shared.getTeamIDs(thisGameID: gameID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var teamIDs):
                    homeTeam = getTeamFromTeamID(teamID: teamIDs[0], allTeams: allTeams)
                    awayTeam = getTeamFromTeamID(teamID: teamIDs[1], allTeams: allTeams)
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func getGamePBP() {
        isLoading = true
        NetworkManager.shared.getGamePBP(thisGameID: gameID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var gameStates):
                    self.gameStates = gameStates
                    if (gameStates.isEmpty) {
                        //game has not started yet
                        alertItem = AlertContext.invalidUsername
                    }
                    else {
                        lastState = gameStates.last ?? lastState
                        getGameStats(thisGameID: gameID)
                    }
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func getGameStats(thisGameID:Int) {
        isLoading = true
        NetworkManager.shared.getGameStats(thisGameID: gameID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var thisStatline):
                    self.thisStatline = thisStatline
                    print(thisStatline)
                    if (thisStatline.isEmpty) {
                        //game has not started yet
                        alertItem = AlertContext.invalidUsername
                    }
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
