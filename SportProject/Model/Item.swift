//
//  Item.swift
//  SportProject
//
//  Created by Mac on 24/05/2023.
//

import Foundation
class Item{
    var leagueId:Int?
    var leagueName:String?
    var leagueLogo:String?
    var sportName:String?
    
    init(leagueId: Int? = nil, leagueName: String? = nil, leagueLogo: String? = nil, sportName: String? = nil) {
        self.leagueId = leagueId
        self.leagueName = leagueName
        self.leagueLogo = leagueLogo
        self.sportName = sportName
    }
}
