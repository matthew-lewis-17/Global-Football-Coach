//
//  TransferHubViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/29/22.
//

import Foundation

final class TransferHubViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var offersFA : [ContractOffer] = []
    @Published var sentOffersTransfer : [TransferOffer] = []
    @Published var receivedOffersTransfer : [TransferOffer] = []

        
    func getFAOffers(thisTeamID: Int) {
        isLoading = true
        NetworkManager.shared.getFAOffers(thisTeamID: thisTeamID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    print(response)
                    self.offersFA = response
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func getTransferOffers(thisTeamID: Int) {
        isLoading = true
        NetworkManager.shared.getTransferOffers(thisTeamID: thisTeamID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    self.sentOffersTransfer = []
                    self.receivedOffersTransfer = []
                    for thisOffer in response {
                        if (thisOffer.offeringTeamID == thisTeamID) {
                            self.sentOffersTransfer.append(thisOffer)

                        }
                        else {
                            self.receivedOffersTransfer.append(thisOffer)
                        }
                    }
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func postWithdrawTransferOffer(thisTransferOffer: TransferOffer) {
        isLoading = true
        NetworkManager.shared.postWithdrawTransferOffer(thisTransferOffer: thisTransferOffer) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    getTransferOffers(thisTeamID: thisTransferOffer.offeringTeamID)
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }

    func postAcceptTransferOffer(thisTransferOffer: TransferOffer) {
        isLoading = true
        NetworkManager.shared.postAcceptTransferOffer(thisTransferOffer: thisTransferOffer) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    getTransferOffers(thisTeamID: thisTransferOffer.offeringTeamID)
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
