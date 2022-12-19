//
//  PlayerGameLogView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/6/22.
//

import SwiftUI

struct PlayerGameLogView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject private var viewModel = OtherTeamPlayerViewModel()
    let thisPlayer: Player
    //let statMap
    var statType : String
    
    var body: some View {
        ScrollView {
            GeneralizedStatlineView(theseStatlines: viewModel.gameLog, statType: statType, lineType: "gamelog")
        }
        .onAppear {
            viewModel.playerID = thisPlayer.id
            viewModel.getGameLog()
        }
    }
}
