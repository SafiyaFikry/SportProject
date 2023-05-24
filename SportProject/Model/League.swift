//
//  League.swift
//  SportProject
//
//  Created by Mac on 20/05/2023.
//

import Foundation

class League : Decodable{
    var league_key : Int?
    var league_name : String?
    var country_key : Int?
    var country_name : String?
    var league_logo : String?
    var country_logo : String?
    init(league_key: Int? = nil, league_name: String? = nil,league_logo: String? = nil) {
        self.league_key = league_key
        self.league_name = league_name
        self.league_logo = league_logo
    }
}
