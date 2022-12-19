//
//  TransferSentCell.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/30/22.
//

import SwiftUI

struct TransferSentCell: View {
    @StateObject private var viewModel = TransferHubViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    let thisTransferOffer : TransferOffer
    var offeredPlayer : Player {
        return getPlayerFromID(playerId: thisTransferOffer.playerID, playerList: loginViewModel.allPlayers)
    }
    
    var body: some View {
        HStack {
            NavigationLink(destination: OtherTeamPlayerView(thisPlayer: offeredPlayer)) {
                VStack {
                    Text(getPlayerName(thisPlayer: offeredPlayer))
                    HStack {
                        Text("Years: " + String(thisTransferOffer.offeredYears))
                        Text("Salary: " + salaryToMillions(thisSalary: thisTransferOffer.offeredSalary))
                        Text("Transfer Fee: " + salaryToMillions(thisSalary: thisTransferOffer.transferFee))
                    }
                }
            }
            //call withdraw offer function
            Button(action: {
                viewModel.postWithdrawTransferOffer(thisTransferOffer: thisTransferOffer)
            }) {
                Image(systemName: "x.circle")
            }
        }
    }
}
