//
//  RosterView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/9/22.
//

import SwiftUI

struct RosterView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject private var viewModel = RosterViewModel()
    @State var editMode: EditMode = .inactive
    @State var isEditing = false
    var body: some View {
        ZStack {
                VStack {
                    Button(action: {
                    isEditing.toggle()
                    editMode = isEditing ? .active : .inactive
                        if isEditing {
                            viewModel.editButtonText="Done"
                        }
                        else {
                            viewModel.editButtonText = "Edit"
                            viewModel.doneEditing()
                        }
                    }) {
                        Text(viewModel.editButtonText)
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(PositionMap.keys, id: \.self) { key in
                                TabButton(title: PositionMap[key] ?? "err", tag: key, selectedTab: $viewModel.selectedPos)
                            }
                        }
                    }
                    TabView(selection: $viewModel.selectedPos) {
                        ForEach(1...16, id: \.self) { key in
                            List{
                                ForEach(Array(viewModel.players.enumerated()), id: \.1.id) {index, player in if player.position==viewModel.selectedPos {RosterCell(player: player, thisIndex: index)}
                                }.onMove(perform: viewModel.move)
                            }.tag(key)
                        }.environment(\.editMode, $editMode)
                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
        .onAppear { viewModel.getRoster(teamID: loginViewModel.userCoach[0].teamID) }
        if viewModel.isLoading { LoadingView() }
        }.alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
    }
}
}


struct RosterView_Previews: PreviewProvider {
    static var previews: some View {
        RosterView()
    }
}
