//
//  StandingStatsDispatchView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/29/22.
//

import SwiftUI
import Foundation

struct StandingStatsDispatchView: View {
    @StateObject private var viewModel = StandingsViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State var selectedTab = 0
    @State var nationVar : Int = 1
    @State var leagueVar : Int = 1
    
    var body: some View {
        VStack {
            HStack {
                //nation picker
                Picker(selection: $nationVar, content: {
                    ForEach(loginViewModel.leagueNations, id: \.self) {thisNation in
                        Text(NationalityMap[thisNation] ?? "error").tag(thisNation)
                    }
                }, label: {
                    HStack {
                        Text(NationalityMap[nationVar] ?? "error")
                        Image(systemName: "chevron.down")
                    }
                }).pickerStyle(MenuPickerStyle())
                //league picker
                Picker(selection: $leagueVar, content: {
                    ForEach(loginViewModel.allLeagues, id: \.self) {thisLeague in
                        if thisLeague.nationality == nationVar {
                            Text(thisLeague.leagueName).tag(thisLeague.id)
                        }
                    }
                }, label: {
                    HStack {
                        Text(LeagueMap[leagueVar] ?? "error")
                        Image(systemName: "chevron.down")
                    }
                }).pickerStyle(MenuPickerStyle())
            }
            HStack {
                TabButton(title: "Standings", tag: 0, selectedTab: $selectedTab)
                TabButton(title: "Scoreboard", tag: 1, selectedTab: $selectedTab)
                TabButton(title: "Statistics", tag: 2, selectedTab: $selectedTab)
            }
            .padding(.top)
            .font(.headline)
            TabView(selection: $selectedTab) {
                StandingsView(nationVar: $nationVar, leagueVar: $leagueVar).tag(0).id(UUID())
                ScoreboardView(nationVar: $nationVar, leagueVar: $leagueVar).tag(1).id(UUID())
                LeagueStatsView(nationVar: $nationVar, leagueVar: $leagueVar).tag(2).id(UUID())
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .onAppear {
            if nationVar == -1 {
                nationVar = viewModel.getThisNation(thisCoach: loginViewModel.userCoach[0], allTeams: loginViewModel.allTeams)
            }
            if leagueVar == -1 {
                leagueVar = viewModel.getThisLeague(thisCoach: loginViewModel.userCoach[0], allTeams: loginViewModel.allTeams)
            }
        }
    }
}
