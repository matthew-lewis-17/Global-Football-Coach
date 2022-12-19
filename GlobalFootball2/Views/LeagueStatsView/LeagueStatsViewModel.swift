//
//  LeagueStatsViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/29/22.
//

import Foundation

final class LeagueStatsViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var curLeagueID = -1
    @Published var passingTop5 : [TotalPlayerStats] = []
    @Published var rushingTop5 : [TotalPlayerStats] = []
    @Published var receivingTop5 : [TotalPlayerStats] = []
    @Published var sacksTop5 : [TotalPlayerStats] = []
    @Published var tacklingTop5 : [TotalPlayerStats] = []
    @Published var interceptionsTop5 : [TotalPlayerStats] = []
    @Published var arrOfTypes : [String] = ["passing", "rushing", "receiving", "sacks", "tackles", "interceptions"]
    
    func topStatsChain() {
        for statType in arrOfTypes {
            getTopStats(thisStatType: statType)
        }
    }
    
    func getTopStats(thisStatType: String) {
        isLoading = true
        NetworkManager.shared.getTopStats(thisStatType: thisStatType, thisLeagueID: curLeagueID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var theseStats):
                    //self.schedule = leagueSchedule
                    switch thisStatType {
                    case "passing":
                        passingTop5 = []
                        passingTop5 = theseStats
                    case "rushing":
                        rushingTop5 = []
                        rushingTop5 = theseStats
                    case "receiving":
                        receivingTop5 = []
                        receivingTop5 = theseStats
                    case "sacks":
                        sacksTop5 = []
                        sacksTop5 = theseStats
                    case "tackles":
                        tacklingTop5 = []
                        tacklingTop5 = theseStats
                    case "interceptions":
                        interceptionsTop5 = []
                        interceptionsTop5 = theseStats
                    default:
                        passingTop5 = []
                        passingTop5 = theseStats
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
