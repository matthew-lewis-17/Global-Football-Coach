//
//  TransferHubView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/21/22.
//

import SwiftUI

struct TransferHubView: View {
    @StateObject private var viewModel = TransferHubViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    //let thisGameID : Int
    @State var selectedTab = 0

    
    var body: some View {
        VStack {
            HStack {
                TabButton(title: "Sent Offers", tag: 0, selectedTab: $selectedTab)
                TabButton(title: "Received Offers", tag: 1, selectedTab: $selectedTab)
                TabButton(title: "Free Agent Offers", tag: 2, selectedTab: $selectedTab)
            }
            TabView(selection: $selectedTab) {
                ScrollView {
                    ForEach(viewModel.sentOffersTransfer, id:\.self) { thisTransferOffer in
                        TransferSentCell(thisTransferOffer: thisTransferOffer)
                    }
                }.tag(0)
                ScrollView {
                    ForEach(viewModel.receivedOffersTransfer, id:\.self) { thisTransferOffer in
                        TransferReceivedCell(thisTransferOffer: thisTransferOffer)
                    }
                }.tag(1)
                ScrollView {
                    ForEach(viewModel.offersFA, id:\.self) { thisContractOffer in
                        Text(String(thisContractOffer.playerID) + " " + String(thisContractOffer.offeredSalary))
                    }
                }.tag(2)
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }.onAppear {
            viewModel.getFAOffers(thisTeamID: loginViewModel.userCoach[0].teamID)
            viewModel.getTransferOffers(thisTeamID: loginViewModel.userCoach[0].teamID)
        }
    }
}
