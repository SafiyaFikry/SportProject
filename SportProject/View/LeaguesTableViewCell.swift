//
//  LeaguesTableViewCell.swift
//  SportProject
//
//  Created by Mac on 19/05/2023.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var videoBtnLeague: UIButton!
    @IBOutlet weak var nameLeague: UILabel!
    @IBOutlet weak var imgLeague: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
