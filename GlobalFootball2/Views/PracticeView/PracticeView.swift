//
//  PracticeView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/5/22.
//

import SwiftUI
import Foundation

struct PracticeView: View {
    @StateObject private var viewModel = PracticeViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Picker("Select Practice Type", selection: $viewModel.practice) {
                ForEach(0..<viewModel.practiceTypes.count, id: \.self) { thisPractice in
                    Text(viewModel.practiceTypes[thisPractice])
                }
            }.pickerStyle(WheelPickerStyle())
            switch viewModel.practice {
            case 0:
                FullTeamPracticeView(practiceType: "pass")
            case 1:
                FullTeamPracticeView(practiceType: "run")
            case 2:
                Text("Team Workouts")
            case 3:
                Text("Special Teams")
            default:
                Text("error")
            }
        }
    }
}


struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
