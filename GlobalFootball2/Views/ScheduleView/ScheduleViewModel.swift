//
//  ScheduleViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/10/22.
//

import Foundation

final class ScheduleViewModel: ObservableObject {
    @Published var schedule:[Schedule] = []
    @Published var allTeams:[Team] = []
    @Published var userTeamID: Int = -1
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    
    func getScheduleTeam() {
        isLoading = true
        NetworkManager.shared.getScheduleTeam(thisTeamID: userTeamID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var teamSchedule):
                    self.schedule = teamSchedule
                    if (schedule.isEmpty) {
                        //you have no coach case
                        alertItem = AlertContext.invalidUsername
                    }
                    else {
                        print(teamSchedule)
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
    
    func getTeam(teamID: Int)->Team {
        for team in allTeams {
            if (team.id == teamID) {
                return team
            }
        }
        return allTeams[0]
    }
}
