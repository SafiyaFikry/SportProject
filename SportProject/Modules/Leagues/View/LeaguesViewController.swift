//
//  LeaguesViewController.swift
//  SportProject
//
//  Created by Mac on 19/05/2023.
//

import UIKit

class LeaguesViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var table: UITableView!
    var sportChosen = ""
    var leaguesViewModel : LeaguesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LCell")
        leaguesViewModel = LeaguesViewModel(manager: NetworkManager())
        leaguesViewModel.passDataToLeaguesController = {[weak self] in
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        }
        leaguesViewModel.getLeaguesFromAPI(sport: sportChosen)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (leaguesViewModel.leagueResponse.count)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LCell") as! LeaguesTableViewCell
        
        cell.layer.borderWidth=2
        cell.layer.borderColor=UIColor( red: 0.0, green: 0.268, blue:0.556, alpha: 1.0 ).cgColor
        cell.layer.cornerRadius = 50.0
        cell.layer.masksToBounds = false
      
        cell.imgLeague.layer.borderWidth = 2
        cell.imgLeague.layer.masksToBounds = false
        cell.imgLeague.layer.borderColor = UIColor( red: 0.572, green: 0.154, blue:0.102, alpha: 1.0 ).cgColor
        cell.imgLeague.layer.cornerRadius = cell.imgLeague.frame.height/2
        cell.imgLeague.clipsToBounds = true
        
        cell.imgLeague.kf.setImage(with: URL(string: leaguesViewModel.leagueResponse[indexPath.row].league_logo ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRicMtQKsDDfklzvGcdWcD8rcHXcyeFQ0WEA&usqp=CAU"),placeholder: UIImage(named: "l"))
        cell.nameLeague.text = leaguesViewModel.leagueResponse[indexPath.row].league_name
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let events = self.storyboard?.instantiateViewController(identifier: "eventV") as! EventsViewController
        events.modalPresentationStyle = .fullScreen
        events.modalTransitionStyle = .crossDissolve
        events.leagueChosen = leaguesViewModel.leagueResponse[indexPath.row]
        events.sportChosen = sportChosen
      
        present(events, animated: true ,completion: nil)
    }
    
}
