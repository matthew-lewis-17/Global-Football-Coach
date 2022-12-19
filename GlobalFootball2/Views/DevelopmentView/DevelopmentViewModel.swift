//
//  DevelopmentViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/5/22.
//

import Foundation

final class DevelopmentViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var offensePanel = 0
    @Published var offenseOptions = ["Passing", "Running"]
    @Published var gameplanPanel = "offense"
    @Published var gameplanOptions = ["offense", "defense", "strategy"]
    @Published var timeManagementOptions = ["Use the clock", "Balanced", "Hurry up"]
    
    
    func postCoach(coach: [Coach]) {
        isLoading=true
        var thisCoach=coach[0]
        NetworkManager.shared.postCoach(coach: [thisCoach]) { [self] result in
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
}
