//
//  ScheduleView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/10/22.
//

import SwiftUI

struct ScheduleView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.schedule) { game in
                    ScheduleCell(thisSchedule:game, homeTeam: viewModel.getTeam(teamID:game.homeTeamID), awayTeam: viewModel.getTeam(teamID:game.awayTeamID))
                }
            }
        }.onAppear {
            viewModel.allTeams = loginViewModel.allTeams
            viewModel.userTeamID = loginViewModel.userCoach[0].teamID
            viewModel.getScheduleTeam()
        }
    }
}


struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
