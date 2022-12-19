//
//  ScoreboardView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/26/22.
//

import SwiftUI

struct ScoreboardView: View {
    @StateObject private var viewModel = ScoreboardViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    @Binding var nationVar : Int
    @Binding var leagueVar : Int
    
    var body: some View {
        ScrollView {
            VStack {
                //nation picker
                Picker(selection: $viewModel.selectedWeek, content: {
                    ForEach(0...19, id: \.self) {thisNum in
                        Text(String(thisNum))
                    }
                }, label: {
                    HStack {
                        Text(String(viewModel.selectedWeek))
                        Image(systemName: "chevron.down")
                    }
                }).pickerStyle(MenuPickerStyle())
                ForEach(viewModel.weekSchedule, id:\.self) { game in
                    ScheduleCell(thisSchedule:game, homeTeam: viewModel.getTeam(teamID:game.homeTeamID), awayTeam: viewModel.getTeam(teamID:game.awayTeamID))
                }
            }
        }.onChange(of: leagueVar) { newLeagueVar in
            viewModel.curLeagueID = newLeagueVar
            viewModel.getScheduleLeague()
        }
        .onChange(of: viewModel.selectedWeek) { newWeek in
            viewModel.setWeekSchedule()
        }
        .onAppear {
            viewModel.selectedWeek = loginViewModel.curMasterState[0].day
            viewModel.curLeagueID = leagueVar
            viewModel.allTeams = loginViewModel.allTeams
            viewModel.getScheduleLeague()
        }
    }
}
