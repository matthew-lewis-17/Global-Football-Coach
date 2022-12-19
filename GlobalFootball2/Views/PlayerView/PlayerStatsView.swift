//
//  PlayerStatsView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/6/22.
//

import SwiftUI

struct PlayerStatsView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject private var viewModel = OtherTeamPlayerViewModel()
    let thisPlayer: Player
    let statType : String
    var colHeaders : [String] {
        switch statType {
        case "Passing":
            return ["GP", "Att.", "Comp.", "%", "Yards", "TD", "INT"]
        case "Rushing":
            return ["GP", "Carries", "Yards", "Avg.", "Fumbles", "TD"]
        case "Receiving":
            return ["GP", "Catches", "Yards", "Avg.", "Fumbles", "TD"]
        case "Sacks":
            return ["GP", "Tackles", "Sacks", "INT", "FF", "FR"]
        case "Tackles":
            return ["GP", "Tackles", "Sacks", "INT", "FF", "FR"]
        case "Interceptions":
            return ["GP", "Tackles", "Sacks", "INT", "FF", "FR"]
        default:
            return ["GP", "Att.", "Comp.", "%", "Yards", "TD", "INT"]
        }
    }
    var colAlignment : [GridItem] {
        switch statType {
        case "Passing":
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        case "Rushing":
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        case "Receiving":
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        case "Defense":
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        default:
            return [GridItem(.flexible()), GridItem(.fixed(95), alignment: .leading), GridItem(.flexible())]
        }
    }
    
    var body: some View {
        LazyVGrid(columns: colAlignment) {
            ForEach(colHeaders, id:\.self) {thisHeader in
                Text(thisHeader)
            }
            ForEach(viewModel.totalStats, id:\.self) {thisStaline in
                switch statType {
                case "Passing":
                    Text(String(thisStaline.gamesPlayed))
                    Text(String(thisStaline.totalAttempts))
                    Text(String(thisStaline.totalComps))
                    let perc = Double(thisStaline.totalComps) / Double(thisStaline.totalAttempts)
                    Text("\(perc, specifier: "%.2f")")
                    Text(String(thisStaline.totalPassYards))
                    Text(String(thisStaline.totalPassTDs))
                    Text(String(thisStaline.totalPassInts))
                case "Rushing":
                    Text(String(thisStaline.gamesPlayed))
                    Text(String(thisStaline.totalCarries))
                    Text(String(thisStaline.totalRushYards))
                    let perc = Double(thisStaline.totalRushYards) / Double(thisStaline.totalCarries)
                    Text("\(perc, specifier: "%.2f")")
                    Text(String(thisStaline.totalFumbles))
                    Text(String(thisStaline.totalRushTDs))
                case "Receiving":
                    Text(String(thisStaline.gamesPlayed))
                    Text(String(thisStaline.totalCatches))
                    Text(String(thisStaline.totalRecYards))
                    let perc = Double(thisStaline.totalRecYards) / Double(thisStaline.totalCatches)
                    Text("\(perc, specifier: "%.2f")")
                    Text(String(thisStaline.totalFumbles))
                    Text(String(thisStaline.totalRecYards))
                case "Defense":
                    Text(String(thisStaline.gamesPlayed))
                    Text(String(thisStaline.totalTackles))
                    Text(String(thisStaline.totalSacks))
                    Text(String(thisStaline.totalInterceptions))
                    Text(String(thisStaline.totalForcedFumbles))
                    Text(String(thisStaline.totalRecoveredFumbles))
                default:
                    Text(String(thisStaline.gamesPlayed))
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
        .onAppear {
            viewModel.playerID = thisPlayer.id
            viewModel.getTotalStats()
        }
    }
}
