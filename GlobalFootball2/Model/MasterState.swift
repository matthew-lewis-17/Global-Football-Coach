//
//  MasterState.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/1/22.
//

import Foundation

struct MasterState: Decodable {
    let year: Int
    let day: Int
    let hour: Int
}

struct MasterStateResponse: Decodable {
    let request: [MasterState]
}
