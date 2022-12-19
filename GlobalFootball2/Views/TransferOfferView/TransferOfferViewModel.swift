//
//  TransferOfferViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/28/22.
//

import Foundation

final class TransferOfferViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var willAccept : String = "false"
    
    //required params when checking to see if player would accept transfer
    //:offeredYears/:offeredSalary/:teamRep/:position/:playerAge/:playerOverall/:playerID
    //teamREP currently not in use
    
    func getContractOfferTransfer(thisContractOffer: ContractOffer, thisPlayer: Player) {
        isLoading = true
        NetworkManager.shared.getContractOfferTransfer(thisContractOffer: thisContractOffer, thisPlayer: thisPlayer) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    self.willAccept = response
                    
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
    
    func postTransferOffer(thisTransferOffer: TransferOffer) {
        isLoading = true
        NetworkManager.shared.postTransferOffer(thisTransferOffer: thisTransferOffer) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    print("successfully posted transfer offer")
                    
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
