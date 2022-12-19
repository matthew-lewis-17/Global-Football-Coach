//
//  PracticeHistoryView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/10/22.
//

import SwiftUI
import Foundation

struct PracticeHistoryView: View {
    //@StateObject private var viewModel = PracticeHistoryView()
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State var finalBoosts : [UpdateBoost] = []
    @State var listOfIDs : [Int] = []
    @State var leavePage : Bool = false

    
    var body: some View {
        VStack {
            Text("fuc")
            ScrollView {
                ForEach(loginViewModel.allPracticeHistory, id: \.self) { thisPractice in
                    HStack {
                        Text(String(thisPractice.week))
                        Spacer()
                        NavigationLink(destination: {
                            ExpandPracticeHistoryView(thisPractice: thisPractice)
                        }, label: {
                            Text(thisPractice.practiceType)
                        })
                        Spacer()
                        NavigationLink(destination: PracticeResultView(thisBoostList: $finalBoosts), isActive: $leavePage, label: {
                            Button(action: {
                                listOfIDs = []
                                for thisIndividualPractice in loginViewModel.allIndividualPractices {
                                    if thisPractice.practiceID == thisIndividualPractice.practiceID {
                                        listOfIDs.append(thisIndividualPractice.playerID)
                                    }
                                }
                                var thisPositionList : [Int] {
                                    if thisPractice.practiceType == "pass" {
                                        return PassPositionList
                                    }
                                    else {
                                        return RunPositionList
                                    }
                                }
                                var BoostDescriptionMap : Dictionary<Int, String> {
                                    if thisPractice.practiceType == "pass" {
                                        return PassBoostDescriptionMap
                                    }
                                    else {
                                        return RunBoostDescriptionMap
                                    }
                                }
                                var thisBoostMap : Dictionary<Int, [[Any]]> {
                                    if thisPractice.practiceType == "pass" {
                                        return BoostMapPass
                                    }
                                    else {
                                        return BoostMapRun
                                    }
                                }
                                finalBoosts = determineBoosts(listOfIDs: listOfIDs, thisPositionList: thisPositionList, thisBoostMap: thisBoostMap)
                                if loginViewModel.runPracticeChain(boostList: finalBoosts, thisPracticeType: thisPractice.practiceType, thisPracticeID: UUID().uuidString) {
                                    print("successful")
                                }
                                leavePage = true
                                //print(finalBoosts)
                            }, label: {
                                Image(systemName: "arrow.clockwise")
                            })
                        })
                        
                    }
                }
            }
        }.onAppear {
            //loginViewModel.getPracticeChain()
        }
    }
    func repeatPractice() {
        
        return
    }
}
