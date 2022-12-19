//
//  StatView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/28/22.
//

import Foundation
import SwiftUI

struct PBPStatView : View {
    @EnvironmentObject var viewModel: PBPViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    var passers:[Statline] {
        viewModel.getPassers()
    }
    var rushers:[Statline] {
        viewModel.getRushers()
    }
    var receivers:[Statline] {
        viewModel.getReceivers()
    }
    var defenders:[Statline] {
        viewModel.getDefenders()
    }
    
    var body: some View {
        VStack {
            Text("Game Statistics")
            Text("Passing")
            GeneralizedStatlineView(theseStatlines: passers, statType: "Passing", lineType: "name")
            Text("Rushing")
            GeneralizedStatlineView(theseStatlines: rushers, statType: "Rushing", lineType: "name")
            Text("Receiving")
            GeneralizedStatlineView(theseStatlines: receivers, statType: "Receiving", lineType: "name")
            Text("Defense")
            GeneralizedStatlineView(theseStatlines: defenders, statType: "Defense", lineType: "name")
        }
    }
}
