//
//  UpcomingEvent.swift
//  SportProject
//
//  Created by Mac on 21/05/2023.
//

import Foundation

class UpcomingEvent :Decodable{
    var event_date : String?
    var event_time: String?
    var event_home_team : String?
    var event_away_team : String?
    var home_team_logo : String?
    var away_team_logo : String?
    var home_team_key : Int?
    var away_team_key : Int?
    
    init(event_date: String? = nil, event_time: String? = nil, event_home_team: String? = nil, event_away_team: String? = nil, home_team_logo: String? = nil, away_team_logo: String? = nil) {
        self.event_date = event_date
        self.event_time = event_time
        self.event_home_team = event_home_team
        self.event_away_team = event_away_team
        self.home_team_logo = home_team_logo
        self.away_team_logo = away_team_logo
    }
}
