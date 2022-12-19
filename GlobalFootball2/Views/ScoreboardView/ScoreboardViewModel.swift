//
//  ScoreboardViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/26/22.
//

import Foundation

final class ScoreboardViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var curLeagueID = -1
    @Published var selectedWeek = -1
    @Published var schedule:[Schedule] = []
    @Published var weekSchedule:[Schedule] = []
    @Published var allTeams:[Team] = []
    
    func getTeam(teamID: Int)->Team {
        for team in allTeams {
            if (team.id == teamID) {
                return team
            }
        }
        return allTeams[0]
    }
    
    func setWeekSchedule() {
        weekSchedule = []
        for game in schedule {
            if game.week == selectedWeek {
                weekSchedule.append(game)
            }
        }
    }
    
    func getScheduleLeague() {
        isLoading = true
        NetworkManager.shared.getScheduleLeague(thisLeagueID: curLeagueID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var leagueSchedule):
                    self.schedule = leagueSchedule
                    if (schedule.isEmpty) {
                        //you have no coach case
                        alertItem = AlertContext.invalidUsername
                    }
                    else {
                        schedule = schedule.sorted(by: {$0.timeSlot < $1.timeSlot})
                        setWeekSchedule()
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
