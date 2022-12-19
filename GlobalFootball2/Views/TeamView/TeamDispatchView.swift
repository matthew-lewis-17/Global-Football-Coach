//
//  TeamDispatchView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/31/22.
//

import Foundation
import SwiftUI

struct TeamDispatchView: View {
    let thisTeam: Team
    @State var dispatchVar : String = "other"
    @EnvironmentObject var loginViewModel: LoginViewModel

    var body: some View {
        VStack {
            switch dispatchVar {
            case "team":
                MyTeamView(: thisPlayer)
            case "other":
                OtherTeamView(thisPlayer: thisPlayer)
            default:
                OtherTeamView(thisPlayer: thisPlayer)
            }
        }.onAppear {
            dispatchVar = decideTeamView(thisTeam: thisTeam, userCoach: loginViewModel.userCoach[0])
        }
    }
}
