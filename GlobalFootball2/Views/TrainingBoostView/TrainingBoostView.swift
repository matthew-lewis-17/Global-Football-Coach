//
//  TrainingBoostView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/5/22.
//

import SwiftUI
import Foundation

struct TrainingBoostView: View {
    @StateObject private var viewModel = TrainingBoostViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        Text("Training boost view")
    }
}


struct TrainingBoostView_Previews: PreviewProvider {
    static var previews: some View {
        DevelopmentView()
    }
}
