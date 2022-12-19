//
//  FullTeamPracticeView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 8/7/22.
//

import SwiftUI
import Foundation

struct FullTeamPracticeView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    let practiceType : String
    var thisPositionList : [Int] {
        if practiceType == "pass" {
            return PassPositionList
        }
        else {
            return RunPositionList
        }
    }
    var BoostDescriptionMap : Dictionary<Int, String> {
        if practiceType == "pass" {
            return PassBoostDescriptionMap
        }
        else {
            return RunBoostDescriptionMap
        }
    }
    var thisBoostMap : Dictionary<Int, [[Any]]> {
        if practiceType == "pass" {
            return BoostMapPass
        }
        else {
            return BoostMapRun
        }
    }
    @State var listOfIDs : [Int] = [Int](repeating: -1, count: 12)
    @State var leavePage : Bool = false
    @State var finalBoosts : [UpdateBoost] = []

    var body: some View {
        VStack {
            Text("select players for " + practiceType + " practice")
            if !listOfIDs.contains(-1) {
                NavigationLink(destination: PracticeResultView(thisBoostList: $finalBoosts), isActive: $leavePage, label: {
                    Button(action: {
                        finalBoosts = determineBoosts(listOfIDs: listOfIDs, thisPositionList: thisPositionList, thisBoostMap: thisBoostMap)
                        if loginViewModel.runPracticeChain(boostList: finalBoosts, thisPracticeType: practiceType, thisPracticeID: UUID().uuidString) {
                            print("successful")
                        }
                        leavePage = true
                        //print(finalBoosts)
                    }, label: {
                        Text("Press Me to practice")
                    })
                })
            }
            ScrollView {
                ForEach(0..<12, id: \.self) { thisNumber in
                    NavigationLink(destination: PracticeSelectPlayerView(thisPosition: thisPositionList[thisNumber], thisPositionList: thisPositionList, thisIDList: $listOfIDs, selectionIndex: thisNumber)) {
                        HStack {
                            Text(PositionMap[thisPositionList[thisNumber]] ?? "error")
                            Spacer()
                            Text(BoostDescriptionMap[thisPositionList[thisNumber]] ?? "error")
                            Spacer()
                            if listOfIDs[thisNumber] == -1 {
                                Text("N/A")
                            }
                            else {
                                Text(String(listOfIDs[thisNumber]))
                            }
                        }
                    }
                }
            }
        }
    }
}
