//
//  SideMenuView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 9/20/22.
//

import SwiftUI

struct SideMenu: View {
    let width: CGFloat
    let menuOpened : Bool
    let toggleMenu: () -> Void
    
    var body: some View {
        ZStack {
            //Dimmed Background view
            GeometryReader {_ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.2))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.toggleMenu()
            }
            //axy menu
            HStack {
                Spacer()
                ZStack {
                    Color(UIColor.gray)
                    VStack {
                        NavigationLink(destination: TransferHubView()) {
                            Text("transfers")
                                .foregroundColor(.white)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            self.toggleMenu()
                        })
                        NavigationLink(destination: FreeAgentsView()) {
                            Text("free agents")
                                .foregroundColor(.white)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            self.toggleMenu()
                        })
                    }
                }
                    .frame(width: self.width)
                    .offset(x: self.menuOpened ? 0 : self.width)
                    .animation(.default)
            }
        }
        .ignoresSafeArea(.all)
    }
}
