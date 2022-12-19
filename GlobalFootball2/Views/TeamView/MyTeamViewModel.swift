//
//  MyTeamViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/31/22.
//

import Foundation


final class MyTeamViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var thisTeamPlayers : [Player] = []
    
    func getAllPlayers(allPlayers: [Player], thisTeamID: Int) {
        for thisPlayer in allPlayers {
            if thisPlayer.teamID == thisTeamID {
                thisTeamPlayers.append(thisPlayer)
            }
        }
        thisTeamPlayers = thisTeamPlayers.sorted(by: {$0.position < $1.position})
        return
    }
}
