//
//  ContractOfferViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/26/22.
//

import Foundation

final class ContractOfferViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var isFreeAgent = false
    @Published var curTopOfferFA : [ContractOffer] = []
    @Published var resignResponse : String = "Undecided"
    
    func getTopContractPlayer(thisPlayerID: Int) {
        isLoading = true
        NetworkManager.shared.getTopContractPlayer(thisPlayerID: thisPlayerID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var bestOffer):
                    print(curTopOfferFA)
                    self.curTopOfferFA = bestOffer
                    
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
    
    func postFreeAgentOffer(thisContractOffer: ContractOffer) {
        isLoading = true
        NetworkManager.shared.postFreeAgentOffer(thisContractOffer: thisContractOffer) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    print(response)
                    
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
    
    func getResignDecision(thisContractOffer: ContractOffer, thisPlayer: Player) {
        isLoading = true
        NetworkManager.shared.getResignDecision(thisContractOffer: thisContractOffer, thisPlayer: thisPlayer) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    self.resignResponse = response
                    
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
