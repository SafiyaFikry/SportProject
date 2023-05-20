//
//  ViewController.swift
//  SportProject
//
//  Created by Mac on 18/05/2023.
//

import UIKit
import Kingfisher
class SportsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var sportsName = ["Foodball","Tennis","Cricket","Basketball","Hockey","Baseball","American Football"]
    var sportsImage = ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIy_juf-LnPOZ20kfKhXlJe-umOk2ltIF65ExvA7qGOaJyqXH2FEnFLkfk9vEm33WtDcI&usqp=CAU","https://www.daysoftheyear.com/cdn-cgi/image/dpr=1%2Cf=auto%2Cfit=cover%2Cheight=650%2Cq=70%2Csharpen=1%2Cwidth=956/wp-content/uploads/play-tennis-day.jpg","https://www.altoadige.it/image/contentid/policy:1.1325493:1507876771/image/image.jpg?f=3x2&w=627&$p$f$w=caf6c4a","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQPHiqyGaXO19F1GEGXwf9ODS76UIwC3Vpiw&usqp=CAU","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaZ8BgdNAmNU0zIjmtmN3UIQ9oDR1xWgGAQg&usqp=CAU","https://techcrunch.com/wp-content/uploads/2019/03/GettyImages-844016022.jpg","https://lh3.googleusercontent.com/4xKvhDZuJFX60A4I5VH8dy8qyWoW5mL6o46kBqEKAIaBm4U7eGFf243erUukVqcPbysxZ56b4GAg=w1440-ns-nd-rj"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sportsName.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCell", for: indexPath) as! SportsCollectionViewCell
        
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
        
        cell.imgSport.kf.setImage(with:URL(string:sportsImage[indexPath.row]))
        cell.nameSport.text = sportsName[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(indexPath.row>=4){
            var alert = UIAlertController(title: "Alert!!", message: "\(sportsName[indexPath.row]) is not available right now", preferredStyle: UIAlertController.Style.actionSheet)
            var action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        else{
            var leagues = self.storyboard?.instantiateViewController(identifier: "leagues") as! LeaguesViewController
            leagues.sportChosen = sportsName[indexPath.row]
            print(leagues.sportChosen.lowercased())
            self.navigationController?.pushViewController(leagues, animated: true)
        }
    }


}

