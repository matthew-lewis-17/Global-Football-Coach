//
//  StatsDetailViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/5/22.
//

import Foundation

final class StatsDetailViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var curLeagueID = -1
    @Published var allTotalStats : [TotalPlayerStats] = []
    @Published var statType : String = "error"
    @Published var sortVar : String = "error"
    @Published var sortDirection : String = "error"
    
    func sortClicked(thisSortVar: String) {
        if sortVar == thisSortVar {
            if sortDirection == "desc" {
                sortDirection = "asc"
            }
            else {
                sortDirection = "desc"
            }
        }
        else {
            sortVar = thisSortVar
            sortDirection = "desc"
        }
        switch sortVar {
        case "Att.":
            if sortDirection == "desc" {
                allTotalStats.sort(by: { $0.totalAttempts > $1.totalAttempts})
            }
            else {
                allTotalStats.sort(by: { $0.totalAttempts < $1.totalAttempts})
            }
        case "Comp.":
            if sortDirection == "desc" {
                allTotalStats.sort(by: { $0.totalComps > $1.totalComps})
            }
            else {
                allTotalStats.sort(by: { $0.totalComps < $1.totalComps})
            }
        case "%":
            if sortDirection == "desc" {
                allTotalStats.sort(by:{Double($0.totalAttempts) / Double($0.totalComps) < Double($1.totalAttempts) / Double($1.totalComps)})
            }
            else {
                allTotalStats.sort(by:{Double($0.totalAttempts) / Double($0.totalComps) > Double($1.totalAttempts) / Double($1.totalComps)})
            }
        case "Yards":
            if statType == "Passing" {
                if sortDirection == "desc" {
                    allTotalStats.sort(by: { $0.totalPassYards > $1.totalPassYards})
                }
                else {
                    allTotalStats.sort(by: { $0.totalPassYards < $1.totalPassYards})
                }
            }
            if statType == "Rushing" {
                if sortDirection == "desc" {
                    allTotalStats.sort(by: { $0.totalRushYards > $1.totalRushYards})
                }
                else {
                    allTotalStats.sort(by: { $0.totalRushYards < $1.totalRushYards})
                }
            }
            if statType == "Receiving" {
                if sortDirection == "desc" {
                    allTotalStats.sort(by: { $0.totalRecYards > $1.totalRecYards})
                }
                else {
                    allTotalStats.sort(by: { $0.totalRecYards < $1.totalRecYards})
                }
            }
        case "TD":
            if statType == "Passing" {
                if sortDirection == "desc" {
                    allTotalStats.sort(by: { $0.totalPassTDs > $1.totalPassTDs})
                }
                else {
                    allTotalStats.sort(by: { $0.totalPassTDs < $1.totalPassTDs})
                }
            }
            if statType == "Rushing" {
                if sortDirection == "desc" {
                    allTotalStats.sort(by: { $0.totalRushTDs > $1.totalRushTDs})
                }
                else {
                    allTotalStats.sort(by: { $0.totalRushTDs < $1.totalRushTDs})
                }
            }
            if statType == "Receiving" {
                if sortDirection == "desc" {
                    allTotalStats.sort(by: { $0.totalRecTDs > $1.totalRecTDs})
                }
                else {
                    allTotalStats.sort(by: { $0.totalRecTDs < $1.totalRecTDs})
                }
            }
        case "INT":
            if statType == "Passing" {
                if sortDirection == "desc" {
                    allTotalStats.sort(by: { $0.totalPassInts > $1.totalPassInts})
                }
                else {
                    allTotalStats.sort(by: { $0.totalPassInts < $1.totalPassInts})
                }
            }
            //defense INT case
            else {
                if sortDirection == "desc" {
                    allTotalStats.sort(by: { $0.totalInterceptions > $1.totalInterceptions})
                }
                else {
                    allTotalStats.sort(by: { $0.totalInterceptions < $1.totalInterceptions})
                }
            }
        case "Carries":
            if sortDirection == "desc" {
                allTotalStats.sort(by: { $0.totalCarries > $1.totalCarries})
            }
            else {
                allTotalStats.sort(by: { $0.totalCarries < $1.totalCarries})
            }
        case "Avg.":
            if statType == "Rushing" {
                if sortDirection == "desc" {
                    allTotalStats.sort(by:{Double($0.totalRushYards) / Double($0.totalCarries) < Double($1.totalRushYards) / Double($1.totalCarries)})
                }
                else {
                    allTotalStats.sort(by:{Double($0.totalRushYards) / Double($0.totalCarries) > Double($1.totalRushYards) / Double($1.totalCarries)})
                }
            }
            else {
                if sortDirection == "desc" {
                    allTotalStats.sort(by:{Double($0.totalRecYards) / Double($0.totalCatches) < Double($1.totalRecYards) / Double($1.totalCatches)})
                }
                else {
                    allTotalStats.sort(by:{Double($0.totalRecYards) / Double($0.totalCatches) > Double($1.totalRecYards) / Double($1.totalCatches)})
                }
            }
        case "Fumbles":
            if sortDirection == "desc" {
                allTotalStats.sort(by: { $0.totalFumbles > $1.totalFumbles})
            }
            else {
                allTotalStats.sort(by: { $0.totalFumbles < $1.totalFumbles})
            }
        case "Tackles":
            if sortDirection == "desc" {
                allTotalStats.sort(by: { $0.totalTackles > $1.totalTackles})
            }
            else {
                allTotalStats.sort(by: { $0.totalTackles < $1.totalTackles})
            }
        case "Sacks":
            if sortDirection == "desc" {
                allTotalStats.sort(by: { $0.totalSacks > $1.totalSacks})
            }
            else {
                allTotalStats.sort(by: { $0.totalSacks < $1.totalSacks})
            }
        case "FF":
            if sortDirection == "desc" {
                allTotalStats.sort(by: { $0.totalForcedFumbles > $1.totalForcedFumbles})
            }
            else {
                allTotalStats.sort(by: { $0.totalForcedFumbles < $1.totalForcedFumbles})
            }
        case "FR":
            if sortDirection == "desc" {
                allTotalStats.sort(by: { $0.totalRecoveredFumbles > $1.totalRecoveredFumbles})
            }
            else {
                allTotalStats.sort(by: { $0.totalRecoveredFumbles < $1.totalRecoveredFumbles})
            }
        default:
            if sortDirection == "desc" {
                allTotalStats.sort(by: { $0.totalAttempts > $1.totalAttempts})
            }
            else {
                allTotalStats.sort(by: { $0.totalAttempts < $1.totalAttempts})
            }
        }
    }
    
    func getLeagueStats() {
        isLoading = true
        NetworkManager.shared.getLeagueStats(thisStatType: statType, thisLeagueID: curLeagueID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var theseStats):
                    allTotalStats = theseStats
                    //self.schedule = leagueSchedule
                    
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
