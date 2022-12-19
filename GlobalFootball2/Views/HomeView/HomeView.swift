//
//  HomeView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/10/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var tabSelection = 0
    @State var menuOpened = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(loginViewModel.userCoach[0].firstname.prefix(1) + ". " + loginViewModel.userCoach[0].lastname)
                    Text("Points: " + String(loginViewModel.userCoach[0].curPoints))
                    if !menuOpened {
                        Button(action: {
                            self.menuOpened.toggle()
                        }) {
                            Image(systemName: "line.3.crossed.swirl.circle")
                        }
                    }
                }
                TabView(selection: $tabSelection) {
                    NavigationView {
                        ZStack {
                            RosterView()
                            SideMenu(width: UIScreen.main.bounds.width/2.2, menuOpened: menuOpened, toggleMenu: toggleMenu)
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Roster")
                    .tabItem {
                        Image(systemName: "house")
                    }.tag(0)
                    NavigationView {
                        ZStack {
                            ScheduleView()
                            SideMenu(width: UIScreen.main.bounds.width/2.2, menuOpened: menuOpened, toggleMenu: toggleMenu)
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Schedule")
                    .tabItem {
                        Image(systemName: "calendar")
                    }.tag(1)
                    NavigationView {
                        ZStack {
                            GameplanView()
                            SideMenu(width: UIScreen.main.bounds.width/2.2, menuOpened: menuOpened, toggleMenu: toggleMenu)
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Gameplan")
                    .tabItem {
                        Image(systemName: "pencil.circle")
                    }.tag(2)
                    NavigationView {
                        ZStack {
                            DevelopmentView()
                            SideMenu(width: UIScreen.main.bounds.width/2.2, menuOpened: menuOpened, toggleMenu: toggleMenu)
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Development")
                    .tabItem {
                        Image(systemName: "chart.bar")
                    }.tag(3)
                    NavigationView {
                        ZStack {
                            StandingStatsDispatchView()
                            SideMenu(width: UIScreen.main.bounds.width/2.2, menuOpened: menuOpened, toggleMenu: toggleMenu)
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Standings")
                    .tabItem {
                        Image(systemName: "list.number")
                    }.tag(4)
                }
            }
        }
        .environmentObject(loginViewModel)
    }
    func toggleMenu() {
        menuOpened.toggle()
    }
}
