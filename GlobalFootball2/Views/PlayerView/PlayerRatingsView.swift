//
//  PlayerRatingsView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/31/22.
//

import Foundation
import SwiftUI

struct PlayerRatingsView: View {
    let thisPlayer: Player
    var overallList:[[String]] {
        return [["Overall", String(thisPlayer.overall)]]
    }
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Text("Overall: " + String(thisPlayer.overall))
            LazyVGrid(columns:[GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(overallList, id: \.self) { rating in
                    let thisDouble : Double = Double(rating[1]) ?? 0
                    let thisColor : UIColor = mixGreenAndRed(greenAmount: CGFloat(thisDouble))
                    Text(rating[0])
                    Text(rating[1]).background(Color.init(thisColor))
                }
            }
            HStack {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(thisPlayer.getPhysicalRatings(), id: \.self) { rating in
                        let thisDouble : Double = Double(rating[1]) ?? 0
                        let thisColor : UIColor = mixGreenAndRed(greenAmount: CGFloat(thisDouble))
                        Text(rating[0])
                        Text(rating[1]).background(Color.init(thisColor))
                    }
                }
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(thisPlayer.getRatings(), id: \.self) { rating in
                        let thisDouble : Double = Double(rating[1]) ?? 0
                        let thisColor : UIColor = mixGreenAndRed(greenAmount: CGFloat(thisDouble))
                        Text(rating[0])
                        Text(rating[1]).background(Color.init(thisColor))
                    }
                }
            }
        }
    }
}
