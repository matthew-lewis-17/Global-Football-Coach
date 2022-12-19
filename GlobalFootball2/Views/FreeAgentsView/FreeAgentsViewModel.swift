//
//  FreeAgentsViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/21/22.
//

import Foundation

final class FreeAgentsViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var freeAgents:[Player] = []
    
    func getFreeAgents() {
        freeAgents = []
    }
}
