//
//  StatDetailView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/4/22.
//

import SwiftUI

struct StatDetailView: View {
    @StateObject private var viewModel = StatsDetailViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    var statType : String
    var leagueVar : Int
    var colHeaders : [String] {
        switch statType {
        case "Passing":
            return ["Att.", "Comp.", "%", "Yards", "TD", "INT"]
        case "Rushing":
            return ["Carries", "Yards", "Avg.", "Fumbles", "TD"]
        case "Receiving":
            return ["Catches", "Yards", "Avg.", "Fumbles", "TD"]
        case "Sacks":
            return ["Tackles", "Sacks", "INT", "FF", "FR"]
        case "Tackles":
            return ["Tackles", "Sacks", "INT", "FF", "FR"]
        case "Interceptions":
            return ["Tackles", "Sacks", "INT", "FF", "FR"]
        default:
            return ["Att.", "Comp.", "%", "Yards", "TD", "INT"]
        }
    }
    var colAlignment : [GridItem] {
        switch statType {
        case "Passing":
            return [GridItem(.fixed(95)), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        case "Rushing":
            return [GridItem(.fixed(95)), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        case "Receiving":
            return [GridItem(.fixed(95)), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        case "Sacks":
            return [GridItem(.fixed(95)), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        case "Tackles":
            return [GridItem(.fixed(95)), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        case "Interceptions":
            return [GridItem(.fixed(95)), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        default:
            return [GridItem(.fixed(95), alignment: .leading), GridItem(.flexible())]
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: colAlignment) {
                    Text("Name")
                    ForEach(colHeaders, id:\.self) { thisHeader in
                        Button(action: {
                            viewModel.sortClicked(thisSortVar: thisHeader)
                        }) {
                            VStack {
                                Text(thisHeader)
                                if viewModel.sortVar == thisHeader {
                                    if viewModel.sortDirection == "asc" {
                                        Image(systemName: "chevron.up")
                                    }
                                    else if viewModel.sortDirection == "desc" {
                                        Image(systemName: "chevron.down")
                                    }
                                }
                            }
                        }
                    }
                    ForEach(viewModel.allTotalStats, id:\.self) {thisStaline in
                        NavigationLink(destination: OtherTeamPlayerView(thisPlayer: getPlayerFromID(playerId:thisStaline.playerID, playerList:loginViewModel.allPlayers))) {
                            Text(getPlayerName(thisPlayer:getPlayerFromID(playerId:thisStaline.playerID, playerList:loginViewModel.allPlayers)))
                        }
                        switch statType {
                        case "Passing":
                            Text(String(thisStaline.totalAttempts))
                            Text(String(thisStaline.totalComps))
                            let perc = Double(thisStaline.totalComps) / Double(thisStaline.totalAttempts)
                            Text("\(perc, specifier: "%.2f")")
                            Text(String(thisStaline.totalPassYards))
                            Text(String(thisStaline.totalPassTDs))
                            Text(String(thisStaline.totalPassInts))
                        case "Rushing":
                            Text(String(thisStaline.totalCarries))
                            Text(String(thisStaline.totalRushYards))
                            let perc = Double(thisStaline.totalRushYards) / Double(thisStaline.totalCarries)
                            Text("\(perc, specifier: "%.2f")")
                            Text(String(thisStaline.totalFumbles))
                            Text(String(thisStaline.totalRushTDs))
                        case "Receiving":
                            Text(String(thisStaline.totalCatches))
                            Text(String(thisStaline.totalRecYards))
                            let perc = Double(thisStaline.totalRecYards) / Double(thisStaline.totalCatches)
                            Text("\(perc, specifier: "%.2f")")
                            Text(String(thisStaline.totalFumbles))
                            Text(String(thisStaline.totalRecYards))
                        case "Sacks":
                            Text(String(thisStaline.totalTackles))
                            Text(String(thisStaline.totalSacks))
                            Text(String(thisStaline.totalInterceptions))
                            Text(String(thisStaline.totalForcedFumbles))
                            Text(String(thisStaline.totalRecoveredFumbles))
                        case "Tackles":
                            Text(String(thisStaline.totalTackles))
                            Text(String(thisStaline.totalSacks))
                            Text(String(thisStaline.totalInterceptions))
                            Text(String(thisStaline.totalForcedFumbles))
                            Text(String(thisStaline.totalRecoveredFumbles))
                        case "Interceptions":
                            Text(String(thisStaline.totalTackles))
                            Text(String(thisStaline.totalSacks))
                            Text(String(thisStaline.totalInterceptions))
                            Text(String(thisStaline.totalForcedFumbles))
                            Text(String(thisStaline.totalRecoveredFumbles))
                        default:
                            Text(String(thisStaline.totalAttempts))
                            Text(String(thisStaline.totalComps))
                            let perc = Double(thisStaline.totalComps) / Double(thisStaline.totalAttempts)
                            Text("\(perc, specifier: "%.2f")")
                            Text(String(thisStaline.totalPassYards))
                            Text(String(thisStaline.totalPassTDs))
                            Text(String(thisStaline.totalPassInts))
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.curLeagueID = leagueVar
            viewModel.statType = statType
            if viewModel.allTotalStats.isEmpty {
                viewModel.getLeagueStats()
            }
        }
    }
}
