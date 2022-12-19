//
//  PBPView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/27/22.
//

import SwiftUI

struct PBPView: View {
    @StateObject private var viewModel = PBPViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    let thisGameID : Int
    @State var selectedTab = 0

    
    var body: some View {
        ZStack {
            VStack {
                BigPBP(thisPBP: viewModel.lastState, thisHomeTeam: viewModel.homeTeam, thisAwayTeam: viewModel.awayTeam)
                HStack {
                    TabButton(title: "Stats", tag: 0, selectedTab: $selectedTab)
                    TabButton(title: "Play-By-Play", tag: 1, selectedTab: $selectedTab)
                }
                TabView(selection: $selectedTab) {
                    ScrollView {
                        PBPStatView().environmentObject(viewModel)
                    }.padding().tag(0)
                    ScrollView {
                        ForEach(viewModel.gameStates) { gameState in
                            PBPCell(thisPBP: gameState, thisHomeTeam: viewModel.homeTeam, thisAwayTeam: viewModel.awayTeam)
                        }
                    }.tag(1)

                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }.onAppear {
                viewModel.gameID = thisGameID
                viewModel.allTeams = loginViewModel.allTeams
                viewModel.getTeamIDs()
                viewModel.allPlayers = loginViewModel.allPlayers
                viewModel.getGamePBP()
            }
            if viewModel.isLoading { LoadingView() }
        }
    }
}
