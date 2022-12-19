//
//  NetworkManager.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/9/22.
//

import UIKit

class NetworkManager: NSObject {
    
    static let shared           = NetworkManager()
    private let cache           = NSCache<NSString, UIImage>()
    
    static let baseURL = "https://global-football-mysql.herokuapp.com/api/get/"
    static let postURL = "https://global-football-mysql.herokuapp.com/api/post/"
    private let playerURL = baseURL + "players"
    private let userURL = baseURL + "users"
    private let coachURL = baseURL + "coach"
    private let scheduleURL = baseURL + "schedule"
    private let teamURL = baseURL + "teams"
    private let gameStateURL = baseURL + "gamestate"
    private let gameStatsURL = baseURL + "stats/game"
    private let masterStateURL = baseURL + "masterstate"
    private let scoutURL = baseURL + "scout"
    private let leagueURL = baseURL + "league"
    private let practiceHistoryGetURL = baseURL + "practicehistory"
    private let individualPracticeGetURL = baseURL + "individualpractice"
    private let scoutPostURL = postURL + "scout"
    private let playerPostURL = postURL + "playersdepthchart"
    private let coachPostURL = postURL + "coachplayfreq"
    private let coachHourPostURL = postURL + "coachhourchange"
    private let boostUpdatePostURL = postURL + "boostupdate"
    private let practiceHistoryPostURL = postURL + "practicehistory"
    private let individualPracticePostURL = postURL + "individualpractice"
    private let contractOfferFAURL = postURL + "contractoffer/freeagent"
    private let transferOfferURL = postURL + "transferoffer"
    //private let contractOfferTransferURL = postURL + "contractoffer/transfer"
    
    
    private override init() {}
    
    //check users for this username of login attempt
    //return this user's profile info if login is successful
    func checkCredentials(username:String, completed: @escaping (Result<[User], APError>) -> Void) {
        guard let url = URL(string: userURL+"/"+username) else {
            completed(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(UserResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    //This returns a list of all players
    func getPlayers(completed: @escaping (Result<[Player], APError>) -> Void) {
        guard let url = URL(string: playerURL) else {
            completed(.failure(.invalidURL))
            return
        }
               
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(PlayerResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    //This returns the master state
    func getMasterState(completed: @escaping (Result<[MasterState], APError>) -> Void) {
        guard let url = URL(string: masterStateURL) else {
            completed(.failure(.invalidURL))
            return
        }
               
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MasterStateResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getScouts(coachID:Int, completed: @escaping (Result<[Scout], APError>) -> Void) {
        guard let url = URL(string: scoutURL+"/"+String(coachID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(ScoutResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.success([]))
            }
        }
        
        task.resume()
    }
    
    //Params: team ID whose roster you are viewing
    //Returns: list of players that belong to that team
    func getRoster(teamID:Int, completed: @escaping (Result<[Player], APError>) -> Void) {
        print("tring: "+playerURL+"/"+String(teamID))
        guard let url = URL(string: playerURL+"/"+String(teamID)) else {
            completed(.failure(.invalidURL))
            return
        }
               
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(PlayerResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    //Params: user ID of the logged in user
    //Returns: list of coaches that this player controls
    func getCoach(userID:Int, completed: @escaping (Result<[Coach], APError>) -> Void) {
        print("URL request: "+coachURL+"/"+String(userID))
        guard let url = URL(string: coachURL+"/"+String(userID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(CoachResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getGamePBP(thisGameID:Int, completed: @escaping (Result<[GameState], APError>) -> Void) {
        guard let url = URL(string: gameStateURL+"/"+String(thisGameID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(GameStateResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getGameStats(thisGameID:Int, completed: @escaping (Result<[Statline], APError>) -> Void) {
        guard let url = URL(string: gameStatsURL+"/"+String(thisGameID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(StatlineResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getScheduleTeam(thisTeamID: Int, completed: @escaping (Result<[Schedule], APError>) -> Void) {
        guard let url = URL(string: scheduleURL + "/team/" + String(thisTeamID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(ScheduleResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getScheduleLeague(thisLeagueID: Int, completed: @escaping (Result<[Schedule], APError>) -> Void) {
        guard let url = URL(string: scheduleURL + "/league/" + String(thisLeagueID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(ScheduleResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getTeams(completed: @escaping (Result<[Team], APError>) -> Void) {
        guard let url = URL(string: teamURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(TeamResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getLeagues(completed: @escaping (Result<[League], APError>) -> Void) {
        guard let url = URL(string: leagueURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(LeagueResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getPracticeHistory(teamID: Int, completed: @escaping (Result<[PracticeHistory], APError>) -> Void) {
        guard let url = URL(string: practiceHistoryGetURL + "/" + String(teamID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(PracticeHistoryResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getIndividualPractices(teamID: Int, completed: @escaping (Result<[IndividualPractice], APError>) -> Void) {
        guard let url = URL(string: individualPracticeGetURL + "/" + String(teamID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(IndividualPracticeResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getTopStats(thisStatType: String, thisLeagueID: Int, completed: @escaping (Result<[TotalPlayerStats], APError>) -> Void) {
        print(NetworkManager.baseURL + "stats/league/" + thisStatType + "/top5/" + String(thisLeagueID))
        guard let url = URL(string: NetworkManager.baseURL + "stats/league/" + thisStatType + "/top5/" + String(thisLeagueID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(TotalPlayerStatsResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getLeagueStats(thisStatType: String, thisLeagueID: Int, completed: @escaping (Result<[TotalPlayerStats], APError>) -> Void) {
        print(NetworkManager.baseURL + "stats/league/" + thisStatType + "/top5/" + String(thisLeagueID))
        guard let url = URL(string: NetworkManager.baseURL + "stats/league/" + thisStatType + "/" + String(thisLeagueID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(TotalPlayerStatsResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getTotalStats(thisPlayerID: Int, completed: @escaping (Result<[TotalPlayerStats], APError>) -> Void) {
        guard let url = URL(string: NetworkManager.baseURL + "stats/player/total/" + String(thisPlayerID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(TotalPlayerStatsResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
       
    func getGameLog(thisPlayerID: Int, completed: @escaping (Result<[Statline], APError>) -> Void) {
        print(NetworkManager.baseURL + "stats/player/gamelog/" + String(thisPlayerID))
        guard let url = URL(string: NetworkManager.baseURL + "stats/player/gamelog/" + String(thisPlayerID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(StatlineResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getResignDecision(thisContractOffer: ContractOffer, thisPlayer : Player, completed: @escaping (Result<String, APError>) -> Void) {
        print(NetworkManager.baseURL + "contractoffer/resign/" + String(thisContractOffer.offeredYears) + "/" + String(thisContractOffer.offeredSalary) + "/" + String(thisContractOffer.position) + "/" + String(thisPlayer.age) + "/" + String(thisPlayer.overall) + "/" + String(thisPlayer.id))
        guard let url = URL(string: NetworkManager.baseURL + "contractoffer/resign/" + String(thisContractOffer.offeredYears) + "/" + String(thisContractOffer.offeredSalary) + "/" + String(thisContractOffer.position) + "/" + String(thisPlayer.age) + "/" + String(thisPlayer.overall) + "/" + String(thisPlayer.id)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(ResignContractOfferResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getTopContractPlayer(thisPlayerID: Int, completed: @escaping (Result<[ContractOffer], APError>) -> Void) {
        print(NetworkManager.baseURL + "topcontractoffer/" + String(thisPlayerID))
        guard let url = URL(string: NetworkManager.baseURL + "topcontractoffer/" + String(thisPlayerID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(ContractOfferResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getFAOffers(thisTeamID: Int, completed: @escaping (Result<[ContractOffer], APError>) -> Void) {
        print(NetworkManager.baseURL + "faoffers/" + String(thisTeamID))
        guard let url = URL(string: NetworkManager.baseURL + "faoffers/" + String(thisTeamID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(ContractOfferResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getTransferOffers(thisTeamID: Int, completed: @escaping (Result<[TransferOffer], APError>) -> Void) {
        print(NetworkManager.baseURL + "transferoffers/" + String(thisTeamID))
        guard let url = URL(string: NetworkManager.baseURL + "transferoffers/" + String(thisTeamID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(TransferOfferResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    //get team IDs [home, away] from gameID
    func getTeamIDs(thisGameID: Int, completed: @escaping (Result<[Int], APError>) -> Void) {
        print(NetworkManager.baseURL + "schedule/game/" + String(thisGameID))
        guard let url = URL(string: NetworkManager.baseURL + "schedule/game/" + String(thisGameID)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(idRequestResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getContractOfferTransfer(thisContractOffer: ContractOffer, thisPlayer: Player, completed: @escaping (Result<String, APError>) -> Void) {
        let requestString = NetworkManager.baseURL + "contractoffer/transfer/" + String(thisContractOffer.offeredYears) + "/" + String(thisContractOffer.offeredSalary) + "/1/" + String(thisPlayer.position) + "/" + String(thisPlayer.age) + "/" + String(thisPlayer.overall) + "/" + String(thisPlayer.id)
        print(requestString)
        guard let url = URL(string: requestString) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(transferContractOfferResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    //func postTransferOffer(thisTransferOffer: TransferOffer)
    func postTransferOffer(thisTransferOffer:TransferOffer, completed: @escaping (Result<String, APError>) -> Void) {
        guard let url = URL(string: transferOfferURL) else {
            completed(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONEncoder().encode(thisTransferOffer)
            request.httpBody=jsonData
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
            completed(.failure(.invalidData))
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: [])
                print(result)
                completed(.success("success"))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func postWithdrawTransferOffer(thisTransferOffer:TransferOffer, completed: @escaping (Result<String, APError>) -> Void) {
        guard let url = URL(string: transferOfferURL + "/withdraw") else {
            completed(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONEncoder().encode(thisTransferOffer)
            request.httpBody=jsonData
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
            completed(.failure(.invalidData))
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: [])
                print(result)
                completed(.success("success"))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func postAcceptTransferOffer(thisTransferOffer:TransferOffer, completed: @escaping (Result<String, APError>) -> Void) {
        guard let url = URL(string: transferOfferURL + "/accept") else {
            completed(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONEncoder().encode(thisTransferOffer)
            request.httpBody=jsonData
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
            completed(.failure(.invalidData))
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: [])
                print(result)
                completed(.success("success"))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    //Params: user ID of the logged in user
    //Returns: list of coaches that this player controls
    func postPlayers(playerList:[Player], completed: @escaping (Result<String, APError>) -> Void) {
        guard let url = URL(string: playerPostURL) else {
            completed(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONEncoder().encode(playerList)
            request.httpBody=jsonData
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
            completed(.failure(.invalidData))
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: [])
                print(result)
                completed(.success("success"))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func postScout(scout:Scout, completed: @escaping (Result<String, APError>) -> Void) {
        guard let url = URL(string: scoutPostURL) else {
            completed(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONEncoder().encode(scout)
            request.httpBody=jsonData
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
            completed(.failure(.invalidData))
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            completed(.success("success"))
            
        }
        
        task.resume()
    }
    
    func postCoach(coach:[Coach], completed: @escaping (Result<String, APError>) -> Void) {
        guard let url = URL(string: coachPostURL) else {
            completed(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONEncoder().encode(coach[0])
            request.httpBody=jsonData
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
            completed(.failure(.invalidData))
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: [])
                print(result)
                completed(.success("success"))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func postCoachHour(thisCoach:Coach, completed: @escaping (Result<String, APError>) -> Void) {
        guard let url = URL(string: coachHourPostURL) else {
            completed(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONEncoder().encode(thisCoach)
            request.httpBody=jsonData
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
            completed(.failure(.invalidData))
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: [])
                print(result)
                completed(.success("success"))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func postBoostUpdate(boostList:[UpdateBoost], completed: @escaping (Result<String, APError>) -> Void) {
        guard let url = URL(string: boostUpdatePostURL) else {
            completed(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONEncoder().encode(boostList)
            request.httpBody=jsonData
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
            completed(.failure(.invalidData))
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            completed(.success("success"))        }
        task.resume()
    }
    
    func postPracticeHistory(thisPracticeHistory:PracticeHistory, completed: @escaping (Result<String, APError>) -> Void) {
        guard let url = URL(string: practiceHistoryPostURL) else {
            completed(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONEncoder().encode(thisPracticeHistory)
            request.httpBody=jsonData
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
            completed(.failure(.invalidData))
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            completed(.success("success"))
        }
        task.resume()
    }
    
    func postIndividualPractice(thisPracticeList:[IndividualPractice], completed: @escaping (Result<String, APError>) -> Void) {
        guard let url = URL(string: individualPracticePostURL) else {
            completed(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONEncoder().encode(thisPracticeList)
            request.httpBody=jsonData
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
            completed(.failure(.invalidData))
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            completed(.success("success"))
            //let result = try JSONSerialization.jsonObject(with: data, options: [])
            //print(result)
            //completed(.success("success"))
        }
        task.resume()
    }
    
    func postFreeAgentOffer(thisContractOffer: ContractOffer, completed: @escaping (Result<String, APError>) -> Void) {
        guard let url = URL(string: contractOfferFAURL) else {
            completed(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONEncoder().encode(thisContractOffer)
            request.httpBody=jsonData
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
            completed(.failure(.invalidData))
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print(data)
            print(response)
            print(error)
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            completed(.success("success"))
            //let result = try JSONSerialization.jsonObject(with: data, options: [])
            //print(result)
            //completed(.success("success"))
        }
        task.resume()
    }
    
}
