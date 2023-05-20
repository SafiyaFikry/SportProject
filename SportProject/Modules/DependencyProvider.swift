//
//  DependencyProvider.swift
//  SportProject
//
//  Created by Mac on 20/05/2023.
//

import Foundation
import UIKit
struct DependencyProvider{
    static var service :NetworkService{
        return NetworkManager()
    }
    static var leaguesViewModel:LeaguesViewModel{
        return LeaguesViewModel(manager: service)
    }
    static var leaguesViewController:LeaguesViewController{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! LeaguesViewController
        vc.leaguesViewModel = leaguesViewModel
        return vc
    }
}

