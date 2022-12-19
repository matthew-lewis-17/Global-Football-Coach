//
//  ReSignPlayerView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 10/9/22.
//

import SwiftUI

struct ReSignPlayerView: View {
    @StateObject private var viewModel = ContractOfferViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    let thisPlayer: Player
    @State var salaryOffer : Double = 0
    @State var yearsOffer = 3
    var thisTeam : Team {
        return getTeamFromTeamID(teamID: loginViewModel.userCoach[0].teamID, allTeams: loginViewModel.allTeams)
    }
    private static let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    var thisBudget : Double {
        return Double(thisTeam.salaryBudget) + Double(thisPlayer.salaryContract)
    }
    @FocusState var isInputActive: Bool
    
    
    var body: some View {
        VStack {
            Text("Offer a new contract to this player")
            Text("Current contract:")
            HStack {
                Text("Years: " + String(thisPlayer.remYearsContract))
                Text("Salary: " + salaryToMillions(thisSalary: thisPlayer.salaryContract))
            }
            Picker("Contract Length", selection: $yearsOffer) {
                ForEach(thisPlayer.remYearsContract..<6) {
                    Text("\($0)")
                }
            }
            Slider (
                value: $salaryOffer,
                in: 0...thisBudget,
                step: 1
            )
            {
                Text(salaryToMillions(thisSalary:Int(salaryOffer)))
            }.padding()
            TextField(salaryToMillions(thisSalary:Int(salaryOffer)), value: $salaryOffer, formatter: Self.formatter)
                .keyboardType(.numberPad)
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                    Button("Click me!") {
                    isInputActive = false
                        }
                    }
                }
            Text(salaryToMillions(thisSalary:Int(salaryOffer)))
            Button(action:{
                viewModel.getResignDecision(thisContractOffer: ContractOffer(playerID: thisPlayer.id, offeringTeamID: thisTeam.id, offeredYears: yearsOffer, offeredSalary: Int(salaryOffer), position: thisPlayer.position, teamRep: thisTeam.reputation), thisPlayer: thisPlayer)
            }) {
                Text("Submit Offer")
            }
            //Text(viewModel.resignResponse)
            if viewModel.resignResponse == "true" {
                Text("Player has agreed to terms")
            }
            else if viewModel.resignResponse == "false" {
                Text("Player has declined contract")
            }
        }.onAppear {
            loginViewModel.getTeams(runNext: false)
        }
    }
}
