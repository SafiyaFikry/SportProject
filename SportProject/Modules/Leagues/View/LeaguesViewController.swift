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
        (leaguesViewModel.result.count)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LCell") as! LeaguesTableViewCell
        
        cell.contentView.layer.cornerRadius = 20.0
        cell.contentView.layer.masksToBounds = true
                
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = false
        // How blurred the shadow is
        cell.layer.shadowRadius = 1.0

        // The color of the drop shadow
        cell.layer.shadowColor = UIColor.black.cgColor

        // How transparent the drop shadow is
        cell.layer.shadowOpacity = 0.2

        // How far the shadow is offset from the UICollectionViewCell’s frame
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        cell.imgLeague.layer.borderWidth = 1
//        cell.imgLeague.layer.shadowRadius=10.0
//        cell.imgLeague.layer.shadowColor=UIColor.black.cgColor
//        cell.imgLeague.layer.shadowOpacity=0.2
//        cell.imgLeague.layer.shadowOffset=CGSize(width: 10, height: 10)
        cell.imgLeague.layer.masksToBounds = false
        cell.imgLeague.layer.borderColor = UIColor.black.cgColor
        cell.imgLeague.layer.cornerRadius = cell.imgLeague.frame.height/2
        cell.imgLeague.clipsToBounds = true
        
        cell.imgLeague.kf.setImage(with: URL(string: leaguesViewModel.result[indexPath.row].league_logo ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRicMtQKsDDfklzvGcdWcD8rcHXcyeFQ0WEA&usqp=CAU"))
        cell.nameLeague.text = leaguesViewModel.result[indexPath.row].league_name
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140.0
    }
    
}
