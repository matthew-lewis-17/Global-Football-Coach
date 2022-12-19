//
//  TransferOffer.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/28/22.
//

import Foundation

struct TransferOffer: Codable, Hashable {
    let id: Int
    let playerID: Int
    let playerTeamID: Int
    let offeringTeamID: Int
    let transferFee: Int
    let offeredYears: Int
    let offeredSalary: Int
    let daysSinceOffer: Int
}

struct TransferOfferResponse: Codable {
    let request: [TransferOffer]
}
