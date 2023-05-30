//
//  LeaguesViewModel.swift
//  SportProject
//
//  Created by Mac on 20/05/2023.
//

import Foundation
class LeaguesViewModel{
    
    var manager : NetworkService
    init(manager: NetworkService) {
        self.manager = manager
    }
    
    var passDataToLeaguesController:(()->Void) = {}

    var leagueResponse : [League]!=[]{
        didSet{
            passDataToLeaguesController()
        }
    }
    
    func getLeaguesFromAPI(sport:String){
        manager.getData(url: URL(string: "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Leagues&APIkey=76009b69e12cd1110e5c20a60fa25e1a3a162d0df70fd17ac68e0a704afbae54")!) {[weak self] (result:LeagueResponse?,error) in
            self?.leagueResponse=result?.result
        }
    }
}
