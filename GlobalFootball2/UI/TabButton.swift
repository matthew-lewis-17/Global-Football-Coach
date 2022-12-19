//
//  TabButton.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/5/22.
//

import Foundation

import Foundation
import SwiftUI

struct TabButton : View {
    let title : String
    let tag : Int
    @Binding var selectedTab : Int
    
    var body: some View {
        VStack {
            Button(title) { withAnimation { selectedTab = tag } }
            .frame(maxWidth: .infinity)
            .foregroundColor(selectedTab == tag ? .primary : .secondary)
            
            Color(selectedTab == tag ? .blue : .clear)
                .frame(height: 4)
                .padding(.horizontal)
        }
    }
}
