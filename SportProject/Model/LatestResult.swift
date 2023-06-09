//
//  LatestResult.swift
//  SportProject
//
//  Created by Mac on 21/05/2023.
//

import Foundation
class LatestResult:Decodable{
    var  event_date : String?
    var  event_time : String?
    var  event_home_team : String?
    var  event_away_team : String?
    var  event_final_result : String?
    var  home_team_logo : String?
    var  away_team_logo: String?
    var  home_team_key : Int?
    var  away_team_key : Int?
}
