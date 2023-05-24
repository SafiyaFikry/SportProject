//
//  FavViewController.swift
//  SportProject
//
//  Created by Mac on 19/05/2023.
//

import UIKit
import Reachability

class FavViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var reachability=try! Reachability()
    var list = [Item]()
    var manager=DCManagerFav.instance
    @IBOutlet weak var table: UITableView!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.list=self.manager.retrieveAll()
        self.table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "FCell")
        self.list=self.manager.retrieveAll()
        self.table.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
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
        
        cell.contentView.layer.cornerRadius = 20.0
        cell.contentView.layer.masksToBounds = true
                
//
//        // How blurred the shadow is
//        cell.layer.shadowRadius = 1.0
//
//        // The color of the drop shadow
//        cell.layer.shadowColor = UIColor.black.cgColor
//
//        // How transparent the drop shadow is
//        cell.layer.shadowOpacity = 0.2
//
//        // How far the shadow is offset from the UICollectionViewCell’s frame
//        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
//
        cell.imgLeague.layer.borderWidth = 1
//        cell.imgLeague.layer.shadowRadius=10.0
//        cell.imgLeague.layer.shadowColor=UIColor.black.cgColor
//        cell.imgLeague.layer.shadowOpacity=0.2
//        cell.imgLeague.layer.shadowOffset=CGSize(width: 10, height: 10)
        cell.imgLeague.layer.masksToBounds = false
        cell.imgLeague.layer.borderColor = UIColor.black.cgColor
        cell.imgLeague.layer.cornerRadius = cell.imgLeague.frame.height/2
        cell.imgLeague.clipsToBounds = true
        
        cell.imgLeague.kf.setImage(with: URL(string: list[indexPath.row].leagueLogo ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRicMtQKsDDfklzvGcdWcD8rcHXcyeFQ0WEA&usqp=CAU"),placeholder: UIImage(named: "l"))
        cell.nameLeague.text = list[indexPath.row].leagueName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var eventV = self.storyboard?.instantiateViewController(identifier: "eventV") as! EventsViewController
        
        reachability.whenReachable = {reachability in
            if(reachability.connection == .cellular || reachability.connection == .wifi){
                eventV.modalPresentationStyle = .fullScreen
                eventV.modalTransitionStyle = .crossDissolve
                let leagueChosen = League(league_key: self.list[indexPath.row].leagueId, league_name: self.list[indexPath.row].leagueName, league_logo: self.list[indexPath.row].leagueLogo)
                eventV.leagueChosen = leagueChosen
                eventV.sportChosen = self.list[indexPath.row].sportName!
              
                self.present(eventV, animated: true ,completion: nil)
            }
        }
        
        reachability.whenUnreachable = {_ in
            let alert = UIAlertController(title: "Network is Unreachable!!", message: "Please, Check Your Internet Then Try Again", preferredStyle: UIAlertController.Style.actionSheet)
            let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
        do{
            try reachability.startNotifier()
        }catch let error{
            print(error)
        }
       
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            manager.deleteRow(itemObj: list[indexPath.row])
            list.remove(at: indexPath.row)
            table.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140.0
    }
}
