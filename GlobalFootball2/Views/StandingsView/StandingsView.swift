//
//  StandingsView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/17/22.
//

import Foundation
import SwiftUI

struct StandingsView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject private var viewModel = StandingsViewModel()
    @Binding var nationVar : Int
    @Binding var leagueVar : Int
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.fixed(175), alignment: .leading), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                Text("")
                Text("W")
                Text("L")
                Text("PF")
                Text("PA")
                Text("PD")
                ForEach(loginViewModel.allTeams, id: \.self) { thisTeam in
                    if thisTeam.leagueID == leagueVar {
                        NavigationLink(destination: MyTeamView(thisTeam: thisTeam)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color(red: Double(thisTeam.primaryR)/255, green: Double(thisTeam.primaryG)/255, blue: Double(thisTeam.primaryB)/255))
                                Text(thisTeam.location)
                                    .foregroundColor(Color(red: Double(thisTeam.secondaryR)/255, green: Double(thisTeam.secondaryG)/255, blue: Double(thisTeam.secondaryB)/255))
                                    .bold()
                            }
                        }
                        Text(String(thisTeam.wins))
                        Text(String(thisTeam.losses))
                        Text(String(thisTeam.pointsFor))
                        Text(String(thisTeam.pointsAgainst))
                        Text(String(thisTeam.pointsFor - thisTeam.pointsAgainst))
                    }
                }
            }
        }
        .onChange(of: nationVar) { newNation in
            leagueVar = viewModel.getTopLeague(newNation: newNation, allLeagues: loginViewModel.allLeagues)
        }
    }
}
