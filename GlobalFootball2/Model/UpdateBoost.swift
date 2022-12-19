//
//  UpdateBoost.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/7/22.
//

import Foundation

struct UpdateBoost: Codable, Identifiable, Hashable {
    let playerID: Int
    let boostAmount: Int
    let variableBoost : String
    var id : UUID {
        UUID()
    }
}
