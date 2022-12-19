//
//  GameplanSlider.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/14/22.
//

import Foundation
import SwiftUI

struct GameplanSlider : View {
    
    @Binding var thisFreq: Double
    @Binding var thisEdit: Bool
    let title:String
    
    var body: some View {
        Text(title)
        Slider(
            value: $thisFreq,
            in: 0...100,
            step: 1
        ) {
            Text(title)
        } onEditingChanged: { editing in
            thisEdit = editing
        }
        Text("\(Int(thisFreq))" + "%")
                .foregroundColor(thisEdit ? .red : .blue)
    }
}
