//
//  LeagueStatsView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/29/22.
//

import SwiftUI

struct LeagueStatsView: View {
    @StateObject private var viewModel = LeagueStatsViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    @Binding var nationVar : Int
    @Binding var leagueVar : Int
    
    var body: some View {
        ScrollView {
            VStack {
                StatsMiniView(statType: "Passing", leagueVar: leagueVar, statList: viewModel.passingTop5)
                StatsMiniView(statType: "Rushing", leagueVar: leagueVar, statList: viewModel.rushingTop5)
                StatsMiniView(statType: "Receiving", leagueVar: leagueVar, statList: viewModel.receivingTop5)
                StatsMiniView(statType: "Sacks", leagueVar: leagueVar, statList: viewModel.sacksTop5)
                StatsMiniView(statType: "Tackles", leagueVar: leagueVar, statList: viewModel.tacklingTop5)
                StatsMiniView(statType: "Interceptions", leagueVar: leagueVar, statList: viewModel.interceptionsTop5)
            }
        }
        .onChange(of: leagueVar) { newLeagueVar in
            viewModel.curLeagueID = newLeagueVar
            viewModel.topStatsChain()
        }
        .onAppear {
            viewModel.curLeagueID = leagueVar
            viewModel.topStatsChain()
        }
    }
}
