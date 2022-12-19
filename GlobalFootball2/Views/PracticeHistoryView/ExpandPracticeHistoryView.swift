//
//  ExpandPracticeHistoryView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/11/22.
//

import Foundation
import SwiftUI

struct ExpandPracticeHistoryView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    let thisPractice : PracticeHistory
    
    var body: some View {
        VStack {
            ForEach(loginViewModel.allIndividualPractices, id: \.self) { thisIndividualPractice in
                if thisIndividualPractice.practiceID == thisPractice.practiceID {
                    HStack {
                        Text(thisIndividualPractice.practiceID)
                        Spacer()
                        Text(String(thisIndividualPractice.playerID))
                    }
                }
            }
        }
    }
}
