//
//  GameplanView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/14/22.
//

import Foundation
import SwiftUI

struct GameplanView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject private var viewModel = GameplanViewModel()
    @State private var isEditing = false
    var body: some View {
        VStack {
            HStack {
                Text("Gameplan")
                Button(action: {
                    if ((loginViewModel.userCoach[0].runFreq+loginViewModel.userCoach[0].passFreq==100) && (loginViewModel.userCoach[0].baseDFreq==100-(loginViewModel.userCoach[0].stopRunFreq+loginViewModel.userCoach[0].stopPassFreq)) && (loginViewModel.userCoach[0].longPassFreq==100-(loginViewModel.userCoach[0].shortPassFreq+loginViewModel.userCoach[0].mediumPassFreq)) && (loginViewModel.userCoach[0].qbRunFreq==100-(loginViewModel.userCoach[0].outsideRunFreq+loginViewModel.userCoach[0].insideRunFreq))) {
                        viewModel.postCoach(coach: loginViewModel.userCoach)
                    }
                    else {
                        viewModel.alertItem=AlertContext.invalidPlayFreq
                    }
                }) {
                    Text("save")
                }
            }
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(viewModel.gameplanOptions, id: \.self) { key in
                        Button(action: { viewModel.gameplanPanel=key}) {
                            Text(key)
                        }
                    }
                }
            }
            switch viewModel.gameplanPanel {
            case "offense":
                Picker(selection: $viewModel.offensePanel, label: Text("Play Type")) {
                    ForEach(0..<viewModel.offenseOptions.count, id: \.self) { index in
                        Text(viewModel.offenseOptions[index])
                    }
                }.pickerStyle(SegmentedPickerStyle())
                switch viewModel.offensePanel {
                case 0:
                    ScrollView{
                        VStack {
                            GameplanSlider(thisFreq: $loginViewModel.userCoach[0].passFreq, thisEdit: $isEditing, title: "Pass Frequency")
                            GameplanSlider(thisFreq: $loginViewModel.userCoach[0].shortPassFreq, thisEdit: $isEditing, title: "Short Pass Frequency")
                            GameplanSlider(thisFreq: $loginViewModel.userCoach[0].mediumPassFreq, thisEdit: $isEditing, title: "Medium Pass Frequency")
                            GameplanSlider(thisFreq: $loginViewModel.userCoach[0].longPassFreq, thisEdit: $isEditing, title: "Long Pass Frequency")
                        }
                    }
                case 1:
                    ScrollView {
                        VStack {
                            GameplanSlider(thisFreq: $loginViewModel.userCoach[0].runFreq, thisEdit: $isEditing, title: "Run Frequency")
                            GameplanSlider(thisFreq: $loginViewModel.userCoach[0].insideRunFreq, thisEdit: $isEditing, title: "Inside Run Frequency")
                            GameplanSlider(thisFreq: $loginViewModel.userCoach[0].outsideRunFreq, thisEdit: $isEditing, title: "Outside Run Frequency")
                            GameplanSlider(thisFreq: $loginViewModel.userCoach[0].qbRunFreq, thisEdit: $isEditing, title: "QB Run Frequency")
                        }
                    }
                default:
                    Text("Error")
                }
            case "defense":
                VStack {
                    GameplanSlider(thisFreq: $loginViewModel.userCoach[0].stopRunFreq, thisEdit: $isEditing, title: "Stop Run Frequency")
                    GameplanSlider(thisFreq: $loginViewModel.userCoach[0].baseDFreq, thisEdit: $isEditing, title: "Base Defense Frequency")
                    GameplanSlider(thisFreq: $loginViewModel.userCoach[0].stopPassFreq, thisEdit: $isEditing, title: "Stop Pass Frequency")
                }
            case "strategy":
                Spacer()
                Text("Playcalling Aggressiveness")
                Picker(selection: $loginViewModel.userCoach[0].aggressiveness, label: Text("Playcalling Aggressiveness")) {
                        ForEach(1..<5, id: \.self) { index in
                            Text(String(index))
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Spacer()
                Text("Time Management")
                Picker(selection: $loginViewModel.userCoach[0].timeManagement, label: Text("Time Management")) {
                    ForEach(0..<viewModel.timeManagementOptions.count, id: \.self) { index in
                        Text(viewModel.timeManagementOptions[index])
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Spacer()
            default:
                Text("Error")
            }
        }
        .onChange(of: loginViewModel.userCoach[0].runFreq) { value in
            if value>=(100-loginViewModel.userCoach[0].passFreq) {
                loginViewModel.userCoach[0].runFreq=100-loginViewModel.userCoach[0].passFreq
            }
        }
        .onChange(of: loginViewModel.userCoach[0].passFreq) { value in
            if value>=(100-loginViewModel.userCoach[0].runFreq) {
                loginViewModel.userCoach[0].passFreq=100-loginViewModel.userCoach[0].runFreq
            }
        }
        .onChange(of: loginViewModel.userCoach[0].shortPassFreq) { value in
            if value>=(100-(loginViewModel.userCoach[0].mediumPassFreq+loginViewModel.userCoach[0].longPassFreq)) {
                loginViewModel.userCoach[0].shortPassFreq=100-(loginViewModel.userCoach[0].mediumPassFreq+loginViewModel.userCoach[0].longPassFreq)
            }
        }
        .onChange(of: loginViewModel.userCoach[0].mediumPassFreq) { value in
            if value>=(100-(loginViewModel.userCoach[0].shortPassFreq+loginViewModel.userCoach[0].longPassFreq)) {
                loginViewModel.userCoach[0].mediumPassFreq=100-(loginViewModel.userCoach[0].shortPassFreq+loginViewModel.userCoach[0].longPassFreq)
            }
        }
        .onChange(of: loginViewModel.userCoach[0].longPassFreq) { value in
            if value>=(100-(loginViewModel.userCoach[0].shortPassFreq+loginViewModel.userCoach[0].mediumPassFreq)) {
                loginViewModel.userCoach[0].longPassFreq=100-(loginViewModel.userCoach[0].shortPassFreq+loginViewModel.userCoach[0].mediumPassFreq)
            }
        }
        .onChange(of: loginViewModel.userCoach[0].insideRunFreq) { value in
            if value>=(100-(loginViewModel.userCoach[0].outsideRunFreq+loginViewModel.userCoach[0].qbRunFreq)) {
                loginViewModel.userCoach[0].insideRunFreq=100-(loginViewModel.userCoach[0].outsideRunFreq+loginViewModel.userCoach[0].qbRunFreq)
            }
        }
        .onChange(of: loginViewModel.userCoach[0].outsideRunFreq) { value in
            if value>=(100-(loginViewModel.userCoach[0].insideRunFreq+loginViewModel.userCoach[0].qbRunFreq)) {
                loginViewModel.userCoach[0].outsideRunFreq=100-(loginViewModel.userCoach[0].insideRunFreq+loginViewModel.userCoach[0].qbRunFreq)
            }
        }
        .onChange(of: loginViewModel.userCoach[0].qbRunFreq) { value in
            if value>=(100-(loginViewModel.userCoach[0].outsideRunFreq+loginViewModel.userCoach[0].insideRunFreq)) {
                loginViewModel.userCoach[0].qbRunFreq=100-(loginViewModel.userCoach[0].outsideRunFreq+loginViewModel.userCoach[0].insideRunFreq)
            }
        }
        .onChange(of: loginViewModel.userCoach[0].stopRunFreq) { value in
            if value>=(100-(loginViewModel.userCoach[0].stopPassFreq+loginViewModel.userCoach[0].baseDFreq)) {
                loginViewModel.userCoach[0].stopRunFreq=100-(loginViewModel.userCoach[0].stopPassFreq+loginViewModel.userCoach[0].baseDFreq)
            }
        }
        .onChange(of: loginViewModel.userCoach[0].stopPassFreq) { value in
            if value>=(100-(loginViewModel.userCoach[0].stopRunFreq+loginViewModel.userCoach[0].baseDFreq)) {
                loginViewModel.userCoach[0].stopPassFreq=100-(loginViewModel.userCoach[0].stopRunFreq+loginViewModel.userCoach[0].baseDFreq)
            }
        }
        .onChange(of: loginViewModel.userCoach[0].baseDFreq) { value in
            if value>=(100-(loginViewModel.userCoach[0].stopRunFreq+loginViewModel.userCoach[0].stopPassFreq)) {
                loginViewModel.userCoach[0].baseDFreq=100-(loginViewModel.userCoach[0].stopRunFreq+loginViewModel.userCoach[0].stopPassFreq)
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}
