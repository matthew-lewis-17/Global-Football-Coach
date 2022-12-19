//
//  FreeAgentsView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/21/22.
//

import SwiftUI

struct FreeAgentsView: View {
    @StateObject private var viewModel = FreeAgentsViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Text("Free Agents")
            ScrollView {
                ForEach(loginViewModel.allPlayers, id:\.self) {thisPlayer in
                    if thisPlayer.teamID == -1 {
                        TeamPlayerCell(thisPlayer: thisPlayer)
                    }
                }
            }
        }
    }
}
