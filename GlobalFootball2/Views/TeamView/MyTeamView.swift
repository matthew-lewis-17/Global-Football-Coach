//
//  MyTeamView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/31/22.
//

//This is actually a view for all teams, will be standard whether it is the user's team or another

import Foundation
import SwiftUI

struct MyTeamView: View {
    let thisTeam: Team
    @StateObject private var viewModel = MyTeamViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Text(thisTeam.location)
            ScrollView {
                ForEach(viewModel.thisTeamPlayers, id: \.self) { thisPlayer in
                    TeamPlayerCell(thisPlayer: thisPlayer)
                }
            }
            .onAppear {
                if viewModel.thisTeamPlayers.count == 0 {
                    viewModel.getAllPlayers(allPlayers: loginViewModel.allPlayers, thisTeamID: thisTeam.id)
                }
            }
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
    }
}
