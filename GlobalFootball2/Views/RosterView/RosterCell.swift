//
//  RosterCell.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/9/22.
//

import SwiftUI

struct RosterCell : View {
    
    let player: Player
    let thisIndex: Int
    
    var body: some View {
        NavigationLink(destination: OtherTeamPlayerView(thisPlayer: player)) {
            HStack {
                VStack {
                    Text(PositionMap[player.position] ?? "err")
                    Text(String(thisIndex))
                }
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Spacer()
                    Text(player.firstName+" "+player.lastName)
                        .font(.title2)
                        .fontWeight(.medium)
                    Spacer()
                    Text(String(player.overall))
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                }
            }.onAppear(perform:{print(player.firstName+": "+String(thisIndex))})
        }
    }
}
