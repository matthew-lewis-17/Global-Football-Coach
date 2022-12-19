//
//  SmallTeamLogo.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/13/22.
//

import SwiftUI

struct SmallTeamLogo: View {
    let thisTeam: Team
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(red: Double(thisTeam.primaryR)/255, green: Double(thisTeam.primaryG)/255, blue: Double(thisTeam.primaryB)/255))
                            .frame(width: 45, height: 20)
            Text("ZZZ")
                .foregroundColor(Color(red: Double(thisTeam.secondaryR)/255, green: Double(thisTeam.secondaryG)/255, blue: Double(thisTeam.secondaryB)/255))
                .frame(width: 36, height: 12)
        }
    }
}
