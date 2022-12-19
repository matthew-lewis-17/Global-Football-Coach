//
//  TransferOfferView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/21/22.
//

import SwiftUI

struct TransferOfferView: View {
    @StateObject private var viewModel = TransferOfferViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    let thisPlayer : Player
    let thisContractOffer : ContractOffer
    let thisTeam : Team
    @State var transferOffer : Double = 0
    @FocusState var isInputActive: Bool
    private static let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
        VStack {
            if (viewModel.willAccept == "true") {
                Text("Accepted Contract")
                HStack {
                    Text("Years: " + String(thisContractOffer.offeredYears))
                    Text("Salary: " + salaryToMillions(thisSalary: thisContractOffer.offeredSalary))
                }
                Text("Transfer Fee")
                let maxVal : Double = max(0, Double(thisTeam.transferBudget))
                Slider (
                    value: $transferOffer,
                    in: 0...maxVal,
                    step: 1
                )
                {
                    Text(salaryToMillions(thisSalary:Int(transferOffer)))
                }.padding()
                TextField(salaryToMillions(thisSalary:Int(transferOffer)), value: $transferOffer, formatter: Self.formatter)
                    .keyboardType(.numberPad)
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                        Button("Click me!") {
                            isInputActive = false
                        }
                    }
                }
                Text(salaryToMillions(thisSalary:Int(transferOffer)))
                NavigationLink(destination: {
                    TransferHubView()
                }) {
                    Text("Submit")
                }
                .simultaneousGesture(TapGesture().onEnded {
                    viewModel.postTransferOffer(thisTransferOffer: TransferOffer(id: 0, playerID: thisPlayer.id, playerTeamID: thisPlayer.teamID, offeringTeamID: thisTeam.id, transferFee: Int(transferOffer), offeredYears: thisContractOffer.offeredYears, offeredSalary: thisContractOffer.offeredSalary, daysSinceOffer: 0))
                })
            }
            else {
                Text("This contract offer was rejected. Please go back to agree to terms with this player before submitting a transfer offer.")
            }
        }
        .onAppear {
            loginViewModel.getTeams(runNext: false)
            viewModel.getContractOfferTransfer(thisContractOffer: thisContractOffer, thisPlayer: thisPlayer)
        }
    }
}
