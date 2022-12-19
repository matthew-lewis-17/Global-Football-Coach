//
//  NameToID.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/29/22.
//

import Foundation

struct NameToID: Codable, Hashable {
    let id : Int
    let firstName : String
    let lastName : String
}

struct NameToIDResponse: Codable {
    let request: [NameToID]
}
