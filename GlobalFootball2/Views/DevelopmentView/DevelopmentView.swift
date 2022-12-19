//
//  DevelopmentView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/5/22.
//

import SwiftUI
import Foundation

struct DevelopmentView: View {
    @StateObject private var viewModel = DevelopmentViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State var selectedTab = 0
    
    var body: some View {
        VStack {
            Text("Development and training view")
            HStack {
                TabButton(title: "Practice", tag: 0, selectedTab: $selectedTab)
                TabButton(title: "Development Hub", tag: 1, selectedTab: $selectedTab)
                TabButton(title: "Practice History", tag: 2, selectedTab: $selectedTab)
            }
            .padding(.top)
            .font(.headline)
            TabView(selection: $selectedTab) {
                PracticeView().tag(0).id(UUID())
                TrainingBoostView().tag(1).id(UUID())
                PracticeHistoryView().tag(2).id(UUID())
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}


struct DevelopmentView_Previews: PreviewProvider {
    static var previews: some View {
        DevelopmentView()
    }
}
