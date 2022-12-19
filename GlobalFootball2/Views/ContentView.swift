//
//  ContentView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/7/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Card().navigationTitle("thicc type")
                NavigationLink(destination: {
                    Text("suck me")
                }, label: { Text("navigate")
                })
            }
        }
    }
}

struct Card: View {
    func drawCard()->(String,Int) {
        let rando = Int.random(in: 2...14)
        return ("card"+String(rando), rando)
    }
    var body: some View {
        Text("baby")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
