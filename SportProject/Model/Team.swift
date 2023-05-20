//
//  Team.swift
//  SportProject
//
//  Created by Mac on 21/05/2023.
//

import Foundation
class Team:Decodable{
    var team_key : String?
    var team_name : String?
    var team_logo : String?
    var players : [Player]?
    var coaches : [Coach]?
}
