//
//  FavViewController.swift
//  SportProject
//
//  Created by Mac on 19/05/2023.
//

import UIKit
import Reachability

class FavViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var reachability = try! Reachability()
    var favoritesViewModel :FavoritesViewModel!
    @IBOutlet weak var table: UITableView!
    var isReachable : Bool!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.favoritesViewModel.getFavorites()
        self.table.reloadData()
        checkIfThereAreFavoriteRecipes(list: favoritesViewModel.list)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "FCell")
        self.favoritesViewModel = FavoritesViewModel(manager: DCManagerFav.instance)
        self.favoritesViewModel.getFavorites()
        self.table.reloadData()
        reachability.whenReachable = {reachability in
            if(reachability.connection == .cellular || reachability.connection == .wifi){
                self.isReachable = true
            }
        }
        reachability.whenUnreachable = {_ in
            self.isReachable = false
        }
        do{
            try reachability.startNotifier()
        }catch let error{
            print(error)
        }
        checkIfThereAreFavoriteRecipes(list: favoritesViewModel.list)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.favoritesViewModel.list.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FCell") as! LeaguesTableViewCell
        
        cell.layer.borderWidth=2
        cell.layer.borderColor=UIColor( red: 0.0, green: 0.268, blue:0.556, alpha: 1.0 ).cgColor
        cell.layer.cornerRadius = 50.0
        cell.layer.masksToBounds = false
      
        cell.imgLeague.layer.borderWidth = 1
        cell.imgLeague.layer.masksToBounds = false
        cell.imgLeague.layer.borderColor = UIColor( red: 0.572, green: 0.154, blue:0.102, alpha: 1.0 ).cgColor
        cell.imgLeague.layer.cornerRadius = cell.imgLeague.frame.height/2
        cell.imgLeague.clipsToBounds = true
        
        cell.imgLeague.kf.setImage(with: URL(string:self.favoritesViewModel.list [indexPath.row].leagueLogo ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRicMtQKsDDfklzvGcdWcD8rcHXcyeFQ0WEA&usqp=CAU"),placeholder: UIImage(named: "l"))
        cell.nameLeague.text = self.favoritesViewModel.list[indexPath.row].leagueName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            if(self.isReachable){
                var eventV = self.storyboard?.instantiateViewController(identifier: "eventV") as! EventsViewController
                eventV.modalPresentationStyle = .fullScreen
                eventV.modalTransitionStyle = .crossDissolve
                let leagueChosen = League(league_key: self.favoritesViewModel.list[indexPath.row].leagueId, league_name: self.favoritesViewModel.list[indexPath.row].leagueName, league_logo: self.favoritesViewModel.list[indexPath.row].leagueLogo)
                eventV.leagueChosen = leagueChosen
                eventV.sportChosen = self.favoritesViewModel.list[indexPath.row].sportName!
                
                self.present(eventV, animated: true ,completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Network is Unreachable!!", message: "Please, Check Your Internet Then Try Again", preferredStyle: UIAlertController.Style.actionSheet)
                let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            self.favoritesViewModel.deleteFavorite(itemObj: self.favoritesViewModel.list[indexPath.row])
            self.favoritesViewModel.list.remove(at: indexPath.row)
            self.table.reloadData()
            self.checkIfThereAreFavoriteRecipes(list: favoritesViewModel.list)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110.0
    }
    func checkIfThereAreFavoriteRecipes(list:[Item]){
        table.isHidden = list.isEmpty
    }
}
