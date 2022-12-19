//
//  ScheduleCell.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/26/22.
//

import Foundation
import SwiftUI

struct ScheduleCell : View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    let thisSchedule: Schedule
    let homeTeam: Team
    let awayTeam: Team
    
    var body: some View {
        NavigationLink(destination: PBPView(thisGameID: thisSchedule.id)) {
            HStack {
                VStack {
                    Text(awayTeam.location)
                    Text("@ " + homeTeam.location)
                }.padding()
                Spacer()
                if (thisSchedule.scoreHome != -1) {
                    VStack {
                        Text(String(thisSchedule.scoreAway))
                        Text(String(thisSchedule.scoreHome))
                    }
                }
                VStack {
                    Text("Week " + String(thisSchedule.week))
                    Text("@ " + String(thisSchedule.timeSlot) + ":00 PM CT")
                }
            }
        }
    }
}
