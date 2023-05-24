//
//  EventsViewModel.swift
//  SportProject
//
//  Created by Mac on 21/05/2023.
//

import Foundation
class EventsViewModel{
    var manager : NetworkService
    init(manager: NetworkService) {
        self.manager = manager
    }
    var passDataToEventsController:(()->Void) = {}
    var upcomingEventResponse : [UpcomingEvent]=[]{
        didSet{
            passDataToEventsController()
        }
    }
    var latestResultResponse : [LatestResult]=[]{
        didSet{
            passDataToEventsController()
        }
    }
    var teamResponse : [Team]=[]{
        didSet{
            passDataToEventsController()
        }
    }
    func getUpcomingEventFromAPI(sport:String,league:League){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let currentDate = dateFormatter.string(from: date)
        let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: date)!
        let nextYearDate = dateFormatter.string(from: nextYear)
        print(currentDate)
        print(nextYearDate)
        guard let id = league.league_key else{
            return
        }
        let url = URL(string:  "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Fixtures&leagueId=\(String(id))&from=\(currentDate)&to=\(nextYearDate)&APIkey=76009b69e12cd1110e5c20a60fa25e1a3a162d0df70fd17ac68e0a704afbae54")
        
        print("https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Fixtures&leagueId=\(String(id))&from=\(currentDate)&to=\(nextYearDate)&APIkey=76009b69e12cd1110e5c20a60fa25e1a3a162d0df70fd17ac68e0a704afbae54")
        manager.getLeagues(url: url! ) {[weak self] (result:UpcomingEventResponse?) in
            print("yuyuyjyhhhhhhhhhhhhhhhhhhh")
            self?.upcomingEventResponse=result!.result!
        }
    }
    func getLatestResultFromAPI(sport:String,league:League){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let currentDate = dateFormatter.string(from: date)
        
        let prevYear = Calendar.current.date(byAdding: .year, value: -1, to: date)!
        let prevYearDate = dateFormatter.string(from: prevYear)
        print(currentDate)
        print(prevYearDate)
        guard let id = league.league_key else{
            return
        }
        let url = URL(string:  "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Fixtures&leagueId=\(String(id))&from=\(prevYearDate)&to=\(currentDate)&APIkey=76009b69e12cd1110e5c20a60fa25e1a3a162d0df70fd17ac68e0a704afbae54")
        manager.getLeagues(url: url! ) {[weak self] (result:LatestResultResponse?) in
            print("yuyuyjyhhhhhhhhhhhhhhhhhhh")
            self?.latestResultResponse=result!.result!
        }
    }
    
    func getTeamFromAPI(sport:String,league:League){
        guard let id = league.league_key else{
            return
        }
        let url = URL(string:  "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Teams&leagueId=\(String(id))&APIkey=76009b69e12cd1110e5c20a60fa25e1a3a162d0df70fd17ac68e0a704afbae54")

        print("https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Teams&leagueId=\(String(id))&APIkey=76009b69e12cd1110e5c20a60fa25e1a3a162d0df70fd17ac68e0a704afbae54")
        manager.getLeagues(url: url! ) {[weak self] (result:TeamResponse?) in
            print("yuyuyjyhhhhhhhhhhhhhhhhhhh")
            self?.teamResponse=result!.result!
        }
    }
}
