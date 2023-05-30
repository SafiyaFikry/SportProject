//
//  TeamsDetailsViewController.swift
//  SportProject
//
//  Created by Mac on 23/05/2023.
//

import UIKit
import Kingfisher

class TeamsDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var teamChosen :Team!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // How blurred the shadow is
        teamImg.layer.shadowRadius = 1.0

        // The color of the drop shadow
        teamImg.layer.shadowColor = UIColor.black.cgColor

        // How transparent the drop shadow is
        teamImg.layer.shadowOpacity = 0.2

        // How far the shadow is offset from the UICollectionViewCell’s frame
        teamImg.layer.shadowOffset = CGSize(width: 5, height: 5)
        teamImg.kf.setImage(with: URL(string: teamChosen.team_logo!),placeholder:UIImage(named: "l") )
        teamName.text="Team Name\n"+teamChosen.team_name!
        coachName.text="Coach Name\n"+(teamChosen.coaches?.first?.coach_name)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teamChosen.players!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell") as! PlayerCellTableViewCell
        cell.layer.borderWidth=2
        cell.layer.borderColor=UIColor( red: 0.0, green: 0.268, blue:0.556, alpha: 1.0 ).cgColor
        cell.layer.cornerRadius = 40.0
        cell.layer.masksToBounds = false
      
        cell.img.layer.borderWidth = 2
        cell.img.layer.masksToBounds = false
        cell.img.layer.borderColor = UIColor( red: 0.572, green: 0.154, blue:0.102, alpha: 1.0 ).cgColor
        cell.img.layer.cornerRadius = 30.0
        cell.img.clipsToBounds = true
        
        cell.img.kf.setImage(with: URL(string:teamChosen.players![indexPath.row].player_image ?? "https://w7.pngwing.com/pngs/104/119/png-transparent-orange-and-white-logo-computer-icons-icon-design-person-person-miscellaneous-logo-silhouette.png"),placeholder: UIImage(named: "l"))
        cell.label.text=teamChosen.players![indexPath.row].player_name
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
   
}
