//
//  OtherTeamPlayerViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/1/22.
//

import Foundation

final class OtherTeamPlayerViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var scouted = false
    @Published var playerID : Int = -1
    @Published var gameLog : [Statline] = []
    @Published var totalStats : [TotalPlayerStats] = []

    
    func checkScouted(allScouts: [Scout], thisPlayer:Player, thisYear:Int) -> Bool {
        //print(allScouts)
        for thisScout in allScouts {
            if thisScout.playerID == thisPlayer.id && thisScout.year == thisYear {
                return true
            }
        }
        return false
    }
    
    func getTotalStats() {
        isLoading = true
        NetworkManager.shared.getTotalStats(thisPlayerID: playerID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var thisTotalStats):
                    totalStats = thisTotalStats
                    print("got toal stats")
                    print(totalStats)
                            
                    
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
    
    func getGameLog() {
        isLoading = true
        NetworkManager.shared.getGameLog(thisPlayerID: playerID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var thisGameLog):
                    gameLog = thisGameLog
                            
                    
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
