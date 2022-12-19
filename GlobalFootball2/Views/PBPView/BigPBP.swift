//
//  BigPBP.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/27/22.
//

import Foundation
import SwiftUI

struct BigPBP : View {
    let thisPBP:GameState
    let thisHomeTeam:Team
    let thisAwayTeam:Team
    var qAndTime:String {
        return ("Q"+String(thisPBP.curQuarter) + " " + secondsToMinutes(numSeconds:thisPBP.curTime))
    }
    
    var fieldPosString:String {
        if (thisPBP.fieldPosition < 50) {
            return "OWN " + String(thisPBP.fieldPosition)
        }
        else {
            return "OPP " + String(100 - thisPBP.fieldPosition)
        }
    }
    
    var downAndDistance:String {
        return (String(thisPBP.curDown) + "&" + String(thisPBP.curDistance) + " on " + fieldPosString)
    }
    var homeTeamScore:String {
        return (thisHomeTeam.location + ": " + String(thisPBP.scoreHome))
    }
    var awayTeamScore:String {
        return (thisAwayTeam.location + ": " + String(thisPBP.scoreAway))
    }
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: MyTeamView(thisTeam: thisHomeTeam)) {
                    Text(homeTeamScore)
                }
                VStack {
                    Text(qAndTime)
                    Text(downAndDistance)
                }
                NavigationLink(destination: MyTeamView(thisTeam: thisAwayTeam)) {
                    Text(awayTeamScore)
                }
            }
            Text(thisPBP.lastPBP)
        }.padding()
    }
}
