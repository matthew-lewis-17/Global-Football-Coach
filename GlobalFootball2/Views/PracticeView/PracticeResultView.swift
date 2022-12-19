//
//  PracticeResultView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/9/22.
//

import SwiftUI
import Foundation

struct PracticeResultView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @Binding var thisBoostList : [UpdateBoost]
    
    var body: some View {
        VStack {
            Text("Development and training view")
            ScrollView {
                ForEach(thisBoostList, id:\.self) {thisBoost in
                    HStack {
                        Text(String(thisBoost.playerID))
                        Spacer()
                        Text(String(thisBoost.variableBoost))
                        Spacer()
                        Text(String(thisBoost.boostAmount))
                    }
                }
            }
        }
    }
}
