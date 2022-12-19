//
//  GlobalFootball2App.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/7/22.
//

import SwiftUI

@main
struct GlobalFootball2App: App {
    let thisFont = Font.custom("Helvetica Neue", size: 14).weight(.semibold)
    var body: some Scene {
        WindowGroup {
            LoginView()
                .font(thisFont)
        }
    }
}
