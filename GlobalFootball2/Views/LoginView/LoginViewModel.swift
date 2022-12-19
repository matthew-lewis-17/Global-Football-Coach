//
//  LoginViewModel.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/9/22.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    @Published var username:String = ""
    @Published var isLoading = false
    @Published var thisUser:[User] = []
    @Published var alertItem: AlertItem?
    @Published var validAuth: Bool = false
    @Published var userCoach: [Coach] = []
    @Published var teamSchedule: [Schedule] = []
    @Published var leagueNations: [Int] = []
    @Published var allLeagues: [League] = []
    @Published var allTeams: [Team] = []
    @Published var allPlayers: [Player] = []
    @Published var curStatline: [Statline] = []
    @Published var curGameStates: [GameState] = []
    @Published var curMasterState: [MasterState] = []
    @Published var allScouts: [Scout] = []
    @Published var allPracticeHistory: [PracticeHistory] = []
    @Published var allIndividualPractices: [IndividualPractice] = []
    @Published var thisTeamPlayers: [Player] = []
    @Published var completedSuccessfully : Bool = false
    @Published var thisIndividualPractice: [IndividualPractice] = []
    @Published var thisBoostList: [UpdateBoost] = []
    
    func checkCredentials() {
        isLoading = true
        
        NetworkManager.shared.checkCredentials(username: username) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let thisUser):
                    self.thisUser = thisUser
                    if (thisUser.isEmpty) {
                        alertItem = AlertContext.invalidUsername
                    }
                    else {
                        print("fetched user")
                        getCoach()
                    }
                            
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    //Get the coach for this user once their  profile is authenticated
    func getCoach() {
        print("trying to link user to coach")
        isLoading = true
        NetworkManager.shared.getCoach(userID: thisUser[0].id) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var userCoach):
                    self.userCoach = userCoach
                    if (userCoach.isEmpty) {
                        //you have no coach case
                        alertItem = AlertContext.invalidUsername
                    }
                    else {
                        getTeams(runNext: true)
                    }
                            
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    
    func getTeams(runNext: Bool) {
        isLoading = true
        NetworkManager.shared.getTeams() { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var allTeams):
                    self.allTeams = allTeams
                    if (allTeams.isEmpty) {
                        //you have no coach case
                        alertItem = AlertContext.invalidUsername
                    }
                    else {
                        if (runNext) {
                            getPlayers()
                        }
                    }
                            
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func getPlayers() {
        isLoading = true
        NetworkManager.shared.getPlayers() { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var allPlayers):
                    self.allPlayers = allPlayers
                    if (allPlayers.isEmpty) {
                        //you have no players
                        alertItem = AlertContext.invalidUsername
                    }
                    else {
                        
                        getThisTeamPlayers()
                        getMasterState()
                    }
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func getThisTeamPlayers() -> [Player] {
        thisTeamPlayers = []
        for thisPlayer in allPlayers {
            if thisPlayer.teamID == userCoach[0].teamID {
                thisTeamPlayers.append(thisPlayer)
            }
        }
        thisTeamPlayers = thisTeamPlayers.sorted(by: {$0.position < $1.position})
        return thisTeamPlayers
    }
    
    func getMasterState() {
        isLoading = true
        NetworkManager.shared.getMasterState() { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var curMasterState):
                    self.curMasterState = curMasterState
                    if (curMasterState.isEmpty) {
                        //you have no players
                        alertItem = AlertContext.invalidUsername
                    }
                    else {
                        getLeagues()
                    }
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func getLeagues() {
        isLoading = true
        NetworkManager.shared.getLeagues() { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var curLeagues):
                    self.allLeagues = curLeagues
                    if (allLeagues.isEmpty) {
                        //you have no players
                        alertItem = AlertContext.invalidUsername
                    }
                    else {
                        self.leagueNations = []
                        for i in self.allLeagues {
                            if !self.leagueNations.contains(i.nationality) {
                                self.leagueNations.append(i.nationality)
                            }
                        }
                        getScouts()
                    }
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func getScouts() {
        isLoading = true
        NetworkManager.shared.getScouts(coachID: userCoach[0].id) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var allScouts):
                    self.allScouts = allScouts
                    getPracticeChain()
                    validAuth = true
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func getPracticeHistory() {
        isLoading = true
        NetworkManager.shared.getPracticeHistory(teamID: userCoach[0].teamID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var thisPracticeHistory):
                    self.allPracticeHistory = thisPracticeHistory
                    //validAuth = true
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func getIndividualPractices() {
        isLoading = true
        NetworkManager.shared.getIndividualPractices(teamID: userCoach[0].teamID) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(var allIndividualPractices):
                    self.allIndividualPractices = allIndividualPractices
                    //validAuth = true
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func postScout(scout: Scout) {
        isLoading=true
        NetworkManager.shared.postScout(scout: scout) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    allScouts.append(scout)
                    //print(response)
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func postCoachHour(thisCoach: Coach) {
        isLoading=true
        NetworkManager.shared.postCoachHour(thisCoach: thisCoach) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    userCoach[0] = thisCoach
                    //print(response)
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func runPracticeChain(boostList: [UpdateBoost], thisPracticeType: String, thisPracticeID: String) -> Bool {
        completedSuccessfully = false
        let thisPracticeHistory : PracticeHistory = PracticeHistory(practiceID: thisPracticeID, practiceType: thisPracticeType, teamID: userCoach[0].teamID, week: -1)
        thisIndividualPractice = []
        thisBoostList = boostList
        for i in (0..<boostList.count) {
            thisIndividualPractice.append(IndividualPractice(playerID: boostList[i].playerID, practiceID: thisPracticeID, practicePosition: i, teamID: userCoach[0].teamID))
        }
        //print(thisPracticeHistory)
        //post practice history
        postPracticeHistory(thisPracticeHistory: thisPracticeHistory)
        //post individual practices
        return completedSuccessfully
    }
    
    func getPracticeChain() {
        getPracticeHistory()
        getIndividualPractices()
        return
    }
    
    func postPracticeHistory(thisPracticeHistory: PracticeHistory) {
        //isLoading=true
        NetworkManager.shared.postPracticeHistory(thisPracticeHistory: thisPracticeHistory) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    //userCoach[0] = thisCoach
                    postIndividualPractice(thisPracticeList: thisIndividualPractice)
                    print(response)
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func postBoostUpdate(boostList: [UpdateBoost]) {
        isLoading=true
        NetworkManager.shared.postBoostUpdate(boostList: thisBoostList) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    //userCoach[0] = thisCoach
                    //completedSuccessfully = true
                    getPracticeChain()
                    print(response)
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    func postIndividualPractice(thisPracticeList: [IndividualPractice]) {
        isLoading=true
        NetworkManager.shared.postIndividualPractice(thisPracticeList: thisPracticeList) { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let response):
                    postBoostUpdate(boostList: thisBoostList)
                    print("success")
                    
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    
    
}
