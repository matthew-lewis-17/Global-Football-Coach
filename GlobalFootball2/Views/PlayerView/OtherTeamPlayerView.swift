//
//  OtherTeamPlayerView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/29/22.
//

import Foundation
import SwiftUI

struct OtherTeamPlayerView: View {
    let thisPlayer: Player
    var playerTeam:Team {
        return getTeamFromTeamID(teamID: thisPlayer.teamID, allTeams: loginViewModel.allTeams)
    }
    @StateObject private var viewModel = OtherTeamPlayerViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State var selectedTab = 0
    var statType : String {
        if thisPlayer.position == 1 {
            return "Passing"
        }
        else if thisPlayer.position == 2 {
            return "Rushing"
        }
        else if thisPlayer.position == 3 || thisPlayer.position == 4 {
            return "Receiving"
        }
        else if thisPlayer.position <= 7 {
            return "Blocking"
        }
        else if thisPlayer.position < 15 {
            return "Defense"
        }
        else if thisPlayer.position == 15 {
            return "Kicking"
        }
        else {
            return "Punting"
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                if thisPlayer.teamID != loginViewModel.userCoach[0].teamID && thisPlayer.loanTeamID != loginViewModel.userCoach[0].teamID {
                    NavigationLink(destination: ContractOfferView(thisPlayer: thisPlayer)) {
                        Image(systemName: "dollarsign.circle")
                    }
                }
                else {
                    NavigationLink(destination: ReSignPlayerView(thisPlayer: thisPlayer)) {
                        Image(systemName: "dollarsign.circle")
                    }
                }
            }
            HStack {
                VStack {
                    Text(thisPlayer.firstName + " " + thisPlayer.lastName)
                    Text(PositionMap[thisPlayer.position] ?? "error")
                    Text(String(thisPlayer.age) + " years old")
                }
                VStack {
                    NavigationLink(destination: MyTeamView(thisTeam: playerTeam)) {
                        Text(playerTeam.location)
                    }
                    Text(salaryToMillions(thisSalary: thisPlayer.salaryContract))
                    Text(String(thisPlayer.remYearsContract) + " years remaining")
                }
            }
            PlayerStatsView(thisPlayer: thisPlayer, statType: statType)
            HStack {
                TabButton(title: "Ratings", tag: 0, selectedTab: $selectedTab)
                TabButton(title: "Game Log", tag: 1, selectedTab: $selectedTab)
            }
            TabView(selection: $selectedTab) {
                VStack {
                    switch viewModel.scouted {
                    case true:
                        PlayerRatingsView(thisPlayer: thisPlayer)
                    case false:
                        Text("Player has not been scouted")
                        Button(action: {
                            loginViewModel.userCoach[0].curPoints -= 1
                            loginViewModel.postCoachHour(thisCoach: loginViewModel.userCoach[0])
                            loginViewModel.postScout(scout: Scout(playerID: thisPlayer.id, coachID: loginViewModel.userCoach[0].id, year: loginViewModel.curMasterState[0].year))
                        }) {
                            Text("Scout this player")
                        }
                    }
                }.tag(0)
                PlayerGameLogView(thisPlayer: thisPlayer, statType: statType).tag(1)
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
            Text("huh")
            Text(loginViewModel.userCoach[0].firstname.prefix(1) + ". " + loginViewModel.userCoach[0].lastname)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Text("Points: " + String(loginViewModel.userCoach[0].curPoints))
        }
    }
        .onAppear {
            if viewModel.checkScouted(allScouts: loginViewModel.allScouts, thisPlayer: thisPlayer, thisYear: loginViewModel.curMasterState[0].year) || thisPlayer.teamID == loginViewModel.userCoach[0].teamID || thisPlayer.loanTeamID == loginViewModel.userCoach[0].teamID {
                viewModel.scouted = true
            }
        }
        .onReceive(loginViewModel.$allScouts) { newScouting in
            if viewModel.checkScouted(allScouts: newScouting, thisPlayer: thisPlayer, thisYear: loginViewModel.curMasterState[0].year) {
                viewModel.scouted = true
            }
        }
    }
}
