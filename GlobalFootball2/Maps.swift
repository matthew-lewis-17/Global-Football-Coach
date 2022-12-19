//
//  Maps.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/10/22.
//

import Foundation
import Collections

let PositionMap: OrderedDictionary = [
    1:"QB",
    2:"RB",
    3:"WR",
    4:"TE",
    5:"OT",
    6:"OG",
    7:"C",
    8:"DT",
    9:"DE",
    10:"OLB",
    11:"ILB",
    12:"CB",
    13:"FS",
    14:"SS",
    15:"K",
    16:"P"
]

let BoostMapPass = [
    1:[[100, "throwAccuracyBoost"]],
    //2:[[40, "routeRunningBoost"], [40, "catchingBoost"], [20, "passBlockingBoost"]],
    3:[[50, "routeRunningBoost"], [100, "catchingBoost"]],
    //4:[[40, "routeRunningBoost"], [40, "catchingBoost"], [20, "passBlockingBoost"]],
    5:[[100, "passBlockBoost"]],
    6:[[100, "passBlockBoost"]],
    7:[[100, "passBlockBoost"]],
    8:[[100, "passRushingBoost"]],
    9:[[100, "passRushingBoost"]],
    //10:[[40, "passRushingBoost"], [40, "coverageBoost"], [20, "tacklingBoost"]],
    //11:[[40, "passRushingBoost"], [40, "coverageBoost"], [20, "tacklingBoost"]],
    12:[[100, "coverageBoost"]],
    //13:[[70, "coverageBoost"], [30, "tacklingBoost"]],
    //14:[[70, "coverageBoost"], [30, "tacklingBoost"]]
]

let BoostMapRun = [
    2:[[50, "ballSecurityBoost"], [100, "evasionBoost"]],
    5:[[100, "runBlockBoost"]],
    6:[[100, "runBlockBoost"]],
    7:[[100, "runBlockBoost"]],
    8:[[100, "runStoppingBoost"]],
    9:[[100, "runStoppingBoost"]],
    10:[[100, "tacklingBoost"]],
    11:[[100, "tacklingBoost"]]
]

let PassBoostDescriptionMap = [
    1: "+ Pass Accuracy",
    //2: "++ Evasion OR ++ Ball Security",
    3: "++ Catching OR ++ Route Running",
    5: "+ Pass Blocking",
    6: "+ Pass Blocking",
    7: "+ Pass Blocking",
    8: "+ Pass Rushing",
    9: "+ Pass Rushing",
    12: "+ Coverage"
]

let RunBoostDescriptionMap = [
    2: "++ Evasion OR ++ Ball Security",
    5: "+ Run Blocking",
    6: "+ Run Blocking",
    7: "+ Run Blocking",
    8: "+ Run Stopping",
    9: "+ Run Stopping",
    10: "+ Tackling",
    11: "+ Tackling"
]

let NationalityMap = [
    1: "United States",
    2: "Mexico",
    3: "Canada",
    4: "France",
    5: "England"
]

let LeagueMap = [
    1: "American Premier League",
    2: "American Second League",
    3: "English Premier Division",
    4: "English Second Division"
]


let PassPositionList = [1,3,3,5,6,7,8,9,9,12,12,12]

let RunPositionList = [2,2,2,5,6,7,8,9,9,10,11,11]

//statsMap[0] is stats header, statsMap[1] is qualifier stat, need to add something for 
let ratingsMap = [
    1: [["Arm Strength", "throwPower"], ["Pass Accuracy", "throwAccuracy"]],
    2: [["Speed", "speed"], ["Evasion", "evasion"]]
]


