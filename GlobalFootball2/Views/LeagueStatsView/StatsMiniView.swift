//
//  StatsMiniView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/4/22.
//

import SwiftUI

struct StatsMiniView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    var statType : String
    var specificStat : String {
        switch statType {
        case "Passing":
            return "Pass Yards"
        case "Rushing":
            return "Rush Yards"
        case "Receiving":
            return "Receiving Yards"
        default:
            return statType
        }
    }
    var leagueVar : Int
    var statList : [TotalPlayerStats]
    
    var body: some View {
        VStack {
            NavigationLink(destination: StatDetailView(statType: statType, leagueVar: leagueVar)) {
                HStack {
                    Text(statType)
                    Image(systemName: "chevron.right")
                }
            }
            LazyVGrid(columns: [GridItem(.fixed(150)), GridItem(.flexible())]) {
                Text("Name")
                Text(specificStat)
                ForEach(statList, id:\.self) { thisTopStat in
                    NavigationLink(destination: OtherTeamPlayerView(thisPlayer: getPlayerFromID(playerId:thisTopStat.playerID, playerList:loginViewModel.allPlayers))) {
                        Text(getPlayerName(thisPlayer:getPlayerFromID(playerId:thisTopStat.playerID, playerList:loginViewModel.allPlayers)))
                    }
                    switch statType {
                    case "Passing":
                        Text(String(thisTopStat.totalPassYards))
                    case "Rushing":
                        Text(String(thisTopStat.totalRushYards))
                    case "Receiving":
                        Text(String(thisTopStat.totalRecYards))
                    case "Sacks":
                        Text(String(thisTopStat.totalSacks))
                    case "Tackles":
                        Text(String(thisTopStat.totalTackles))
                    case "Interceptions":
                        Text(String(thisTopStat.totalInterceptions))
                    default:
                        Text(String(thisTopStat.totalPassYards))
                    }
                }
            }
        }
    }
}

