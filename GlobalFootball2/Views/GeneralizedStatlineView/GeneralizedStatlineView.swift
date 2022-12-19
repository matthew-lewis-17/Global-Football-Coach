//
//  GeneralizedStatlineView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/7/22.
//

import SwiftUI

struct GeneralizedStatlineView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    let theseStatlines: [Statline]
    let statType : String
    //if this is a gamelog, we will link to the name of the
    let lineType : String
    var colList : [GridItem] {
        switch statType {
        case "Passing":
            return [GridItem(.flexible()), GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(35)), GridItem(.fixed(35))]
        case "Rushing":
            return [GridItem(.flexible()), GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(35)), GridItem(.fixed(35))]
        case "Receiving":
            return [GridItem(.flexible()), GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(35)), GridItem(.fixed(35))]
        case "Defense":
            return [GridItem(.flexible()), GridItem(.fixed(65)), GridItem(.fixed(50)), GridItem(.fixed(35)), GridItem(.fixed(35)), GridItem(.fixed(35))]
        default:
            return [GridItem(.flexible()), GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50))]
        }
    }
    var colHeaders : [String] {
        switch statType {
        case "Passing":
            return ["", "C/ATT", "YDS", "AVG", "TD", "INT"]
        case "Rushing":
            return ["", "CAR", "YDS", "AVG", "TD", "FUM"]
        case "Receiving":
            return ["", "REC", "YDS", "AVG", "TD", "FUM"]
        case "Defense":
            return ["", "TACKLES", "SACKS", "INT", "FF", "FR"]
        default:
            return ["", "TACKLES", "SACKS", "INT", "FF", "FR"]
        }
    }
    
    var body: some View {
        LazyVGrid(columns: colList) {
            ForEach(colHeaders, id:\.self) { thisHeader in
                Text(thisHeader)
            }
            ForEach(theseStatlines, id:\.self) {thisStatline in
                if lineType == "gamelog" {
                    NavigationLink(destination: PBPView(thisGameID: thisStatline.gameID)) {
                        Text("Game")
                    }
                }
                else if lineType == "name" {
                    let tempPlayer : Player = getPlayerFromID(playerId: thisStatline.playerID, playerList: loginViewModel.allPlayers)
                    let thisTeam = getTeamFromTeamID(teamID: getPlayerFromID(playerId: thisStatline.playerID, playerList: loginViewModel.allPlayers).teamID, allTeams: loginViewModel.allTeams)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(red: Double(thisTeam.primaryR)/255, green: Double(thisTeam.primaryG)/255, blue: Double(thisTeam.primaryB)/255))
                        NavigationLink(destination: OtherTeamPlayerView(thisPlayer: tempPlayer)) {
                            Text(getPlayerName(thisPlayer:tempPlayer))
                                .foregroundColor(Color(red: Double(thisTeam.secondaryR)/255, green: Double(thisTeam.secondaryG)/255, blue: Double(thisTeam.secondaryB)/255))
                                .bold()
                        }
                    }
                }
                switch statType {
                case "Passing":
                    Text(String(thisStatline.passCompletions) + "/" + String(thisStatline.passAttempts))
                    Text(String(thisStatline.passYards))
                    let perc = Double(thisStatline.passYards) / Double(thisStatline.passCompletions)
                    Text("\(perc, specifier: "%.2f")")
                    Text(String(thisStatline.passTDs))
                    Text(String(thisStatline.passInts))
                case "Rushing":
                    Text(String(thisStatline.carries))
                    Text(String(thisStatline.rushYards))
                    let perc = Double(thisStatline.rushYards) / Double(thisStatline.carries)
                    Text("\(perc, specifier: "%.2f")")
                    Text(String(thisStatline.rushTDs))
                    Text(String(thisStatline.fumbles))
                case "Receiving":
                    Text(String(thisStatline.catches))
                    Text(String(thisStatline.recYards))
                    let perc = Double(thisStatline.recYards) / Double(thisStatline.catches)
                    Text("\(perc, specifier: "%.2f")")
                    Text(String(thisStatline.recTDs))
                    Text(String(thisStatline.fumbles))
                case "Defense":
                    Text(String(thisStatline.tackles))
                    Text(String(thisStatline.sacks))
                    Text(String(thisStatline.interceptions))
                    Text(String(thisStatline.forcedFumbles))
                    Text(String(thisStatline.recoveredFumbles))
                default:
                    Text(String(thisStatline.tackles))
                    Text(String(thisStatline.sacks))
                    Text(String(thisStatline.interceptions))
                    Text(String(thisStatline.forcedFumbles))
                    Text(String(thisStatline.recoveredFumbles))
                }
            }
        }
    }
}
