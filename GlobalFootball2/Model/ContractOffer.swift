//
//  ContractOffer.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/26/22.
//

import Foundation

struct ContractOffer: Codable, Hashable {
    let playerID: Int
    let offeringTeamID: Int
    let offeredYears: Int
    let offeredSalary: Int
    let position: Int
    let teamRep: Int
}

struct ContractOfferResponse: Codable {
    let request: [ContractOffer]
}

struct transferContractOfferResponse : Decodable {
    let request: String
}

struct ResignContractOfferResponse : Decodable {
    let request: String
}
