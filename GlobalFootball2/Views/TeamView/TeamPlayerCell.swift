//
//  TeamPlayerCell.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/3/22.
//

import Foundation
import SwiftUI

struct TeamPlayerCell: View {
    let thisPlayer: Player
    //@StateObject private var viewModel = MyTeamViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State var perceivedOverall : String = "?"
    
    
    var body: some View {
        NavigationLink(destination: OtherTeamPlayerView(thisPlayer: thisPlayer)) {
            HStack {
                Text(PositionMap[thisPlayer.position] ?? "error")
                VStack {
                    Text(thisPlayer.firstName + " " + thisPlayer.lastName)
                    Text("Age: " + String(thisPlayer.age))
                }
                Spacer()
                if perceivedOverall == "?" {
                    Text(perceivedOverall)
                }
                else {
                    let thisDouble : Double = Double(perceivedOverall) ?? 0
                    let thisColor : UIColor = mixGreenAndRed(greenAmount: CGFloat(thisDouble))
                    Text(perceivedOverall).background(Color.init(thisColor))
                }
            }
        }.onAppear {
            if checkScouted(allScouts: loginViewModel.allScouts, thisPlayer: thisPlayer, thisYear: loginViewModel.curMasterState[0].year) || thisPlayer.teamID == loginViewModel.userCoach[0].teamID {
                perceivedOverall = String(thisPlayer.overall)
            }
        }
    }
    
    func checkScouted(allScouts: [Scout], thisPlayer:Player, thisYear:Int) -> Bool {
        print(allScouts)
        for thisScout in allScouts {
            if thisScout.playerID == thisPlayer.id && thisScout.year == thisYear {
                return true
            }
        }
        return false
    }
    
}
