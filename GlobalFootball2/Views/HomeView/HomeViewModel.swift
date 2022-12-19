//
//  HomeViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/10/22.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var viewVar:String = "roster"
    
    func setViewVar(newViewVar:String)->Void {
        viewVar=newViewVar
    }
}
