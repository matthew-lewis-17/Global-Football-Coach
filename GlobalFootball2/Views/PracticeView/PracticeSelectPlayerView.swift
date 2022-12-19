//
//  PracticeSelectPlayerView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/7/22.
//

import SwiftUI
import Foundation

struct PracticeSelectPlayerView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject private var viewModel = PracticeViewModel()
    let thisPosition : Int
    let thisPositionList : [Int]
    @Binding var thisIDList : [Int]
    let selectionIndex : Int
    @State var sortingVar : String = "throwAccuracyBoost"
    //@State var sortedTeamPlayers : [Player] = []

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(PositionMap[thisPosition] ?? "error")
                Spacer()
                Text(sortingVar)
                Spacer()
                Picker(selection: $sortingVar, content: {
                    Group {
                        Text("Throw Accuracy Boost").tag("throwAccuracyBoost")
                        Text("Evasion Boost").tag("evasionBoost")
                        Text("Ball Security Boost").tag("ballSecurityBoost")
                        Text("Route Running Boost").tag("routeRunningBoost")
                        Text("Catching Boost").tag("catchingBoost")
                        Text("Pass Blocking Boost").tag("passBlockBoost")
                    }
                    Group {
                        Text("Run Blocking Boost").tag("runBlockBoost")
                        Text("Pass Rushing Boost").tag("passRushingBoost")
                        Text("Run Stopping Boost").tag("runStoppingBoost")
                        Text("Tackling Boost").tag("tacklingBoost")
                        Text("Coverage Boost").tag("coverageBoost")
                    }
                }) {
                    Image(systemName: "arrow.up.arrow.down")
                }.pickerStyle(.menu)
            }
            List(viewModel.sortedTeamPlayers, id:\.self) { thisPlayer in
                HStack {
                    if thisIDList.contains(thisPlayer.id) {
                        VStack {
                            Image(systemName: "bolt")
                            Text(PositionMap[thisPositionList[thisIDList.firstIndex(where: {$0 == thisPlayer.id}) ?? -1]] ?? "error")
                        }
                    }
                    VStack {
                        Text(getPlayerName(thisPlayer: thisPlayer))
                        Text(PositionMap[thisPlayer.position] ?? "error")
                    }
                    Spacer()
                    Text(String(viewModel.getThisBoost(thisPlayer: thisPlayer, thisBoost: sortingVar)))
                }.onTapGesture {
                    if !thisIDList.contains(thisPlayer.id) {
                        thisIDList[selectionIndex] = thisPlayer.id
                    }
                    else if thisIDList[selectionIndex] == thisPlayer.id {
                        thisIDList[selectionIndex] = -1
                    }
                }
                .foregroundColor(thisIDList.contains(thisPlayer.id) ? .red : .green)
            }
        }.onAppear {
            viewModel.thisTeamPlayers = loginViewModel.thisTeamPlayers
            viewModel.sortedTeamPlayers = loginViewModel.thisTeamPlayers.sorted(by: {
                $0.throwAccuracyBoost > $1.throwAccuracyBoost
            })
        }
        .onChange(of: sortingVar) { newVar in
            viewModel.sortingVarChanged(thisNewVar: newVar)
            
        }
    }
}
