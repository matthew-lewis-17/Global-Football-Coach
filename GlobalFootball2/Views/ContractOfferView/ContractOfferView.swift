//
//  ContractOfferView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/21/22.
//

import SwiftUI

struct ContractOfferView: View {
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
    @FocusState var isInputActive: Bool
    
    
    var body: some View {
        VStack {
            if (thisTeam.salaryBudget <= 0) {
                Text("Your salary budget is not enough to offer this player")
            }
            else {
                if thisPlayer.remYearsContract != 0 {
                    Text("You must agree to terms with this player before submitting a transfer offer")
                    Text("Current Contract")
                    HStack {
                        Text("Years: " + String(thisPlayer.remYearsContract))
                        Text("Salary: " + salaryToMillions(thisSalary: thisPlayer.salaryContract))
                    }
                }
                else {
                    Text("Offer a contract to this free agent")
                    if viewModel.curTopOfferFA.count > 0 {
                        Text("Current best offer:")
                        HStack {
                            Text("Years: " + String(viewModel.curTopOfferFA[0].offeredYears))
                            Text("Salary: " + salaryToMillions(thisSalary: viewModel.curTopOfferFA[0].offeredSalary))
                        }
                    }
                    else {
                        Text("This free agent has not been offered a contract")
                    }
                }
                Picker("Contract Length", selection: $yearsOffer) {
                    ForEach(1..<6) {
                        Text("\($0)")
                    }
                }
                Slider (
                    value: $salaryOffer,
                    in: 0...Double(thisTeam.salaryBudget),
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
                if thisPlayer.teamID == -1 {
                    Button(action:{
                        viewModel.getTopContractPlayer(thisPlayerID: thisPlayer.id)
                        viewModel.postFreeAgentOffer(thisContractOffer: ContractOffer(playerID: thisPlayer.id, offeringTeamID: thisTeam.id, offeredYears: yearsOffer, offeredSalary: Int(salaryOffer), position: thisPlayer.position, teamRep: thisTeam.reputation))
                    }) {
                               Text("Submit Offer")
                    }
                }
                else {
                    NavigationLink(destination: TransferOfferView(thisPlayer: thisPlayer, thisContractOffer: ContractOffer(playerID: thisPlayer.id, offeringTeamID: thisTeam.id, offeredYears: yearsOffer, offeredSalary: Int(salaryOffer), position: thisPlayer.position, teamRep: thisTeam.reputation), thisTeam: thisTeam)) {
                        Text("Submit Offer")
                    }
                }
            }
        }.onAppear {
            loginViewModel.getTeams(runNext: false)
            if thisPlayer.teamID == -1 {
                viewModel.isFreeAgent = true
            }
            viewModel.getTopContractPlayer(thisPlayerID: thisPlayer.id)
        }
    }
}
