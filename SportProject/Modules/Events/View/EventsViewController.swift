//
//  EventsViewController.swift
//  SportProject
//
//  Created by Mac on 24/05/2023.
//

import UIKit

class EventsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var collection: UICollectionView!
    var leagueChosen :League!
    var sportChosen = ""
    var eventsViewModel:EventsViewModel!
    @IBOutlet weak var fav: UIButton!
    var managerFav=DCManagerFav.instance
    
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        let item = Item(leagueId:leagueChosen.league_key,leagueName: leagueChosen.league_name,leagueLogo: leagueChosen.league_logo,sportName: sportChosen)
        
        if(sender.imageView?.image == UIImage(systemName: "heart")){
            sender.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
            managerFav.insertRow(itemObj: item)
        }
        else{
            sender.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
            managerFav.deleteRow(itemObj: item)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = Item(leagueId:leagueChosen.league_key,leagueName: leagueChosen.league_name,leagueLogo: leagueChosen.league_logo,sportName: sportChosen)
        
        if(managerFav.isExist(item: item)){
            fav.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
        }
        else if(!managerFav.isExist(item: item)){
            fav.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
        }
        let layout = UICollectionViewCompositionalLayout{sectionIndex,enviroment in
            switch sectionIndex {
                case 0 :
                    return self.drawFirstSectionLayout()
                case 1 :
                    return self.drawSecondSectionLayout()
                default:
                    return self.drawThirdSectionLayout()
            }
        }
        collection.register(UpcomingEvents.self, forSupplementaryViewOfKind: "upcomingEvents", withReuseIdentifier: "upcomingEventsId")
        collection.register(LatestResults.self, forSupplementaryViewOfKind: "latestResults", withReuseIdentifier: "latestResultsId")
        collection.register(Teams.self, forSupplementaryViewOfKind: "teams", withReuseIdentifier: "teamsId")
        collection.setCollectionViewLayout(layout, animated: true)
        
        
        eventsViewModel = EventsViewModel(manager: NetworkManager())
        
        eventsViewModel.passDataToEventsController = {[weak self] in
            DispatchQueue.main.async {
                self?.collection.reloadData()
            }
        }
        eventsViewModel.getUpcomingEventFromAPI(sport: sportChosen, league: leagueChosen!)
        
        eventsViewModel.getLatestResultFromAPI(sport: sportChosen, league: leagueChosen!)
      
        eventsViewModel.getTeamFromAPI(sport: sportChosen, league: leagueChosen!)
        
        print(eventsViewModel.teamResponse.count)
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section){
            case 0:
                return eventsViewModel.upcomingEventResponse.count
            case 1:
                return eventsViewModel.latestResultResponse.count
            case 2:
                return eventsViewModel.teamResponse.count
            default:
                return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch(indexPath.section){
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "first", for: indexPath) as! FirstCollectionViewCell
            
            cell.layer.borderWidth=1
            cell.layer.borderColor=UIColor( red: 0.0, green: 0.268, blue:0.556, alpha: 1.0 ).cgColor
            cell.layer.cornerRadius = 5.0
            cell.layer.masksToBounds = false
           
            
            cell.team1Img.kf.setImage(with: URL(string:eventsViewModel.upcomingEventResponse[indexPath.row].home_team_logo!),placeholder: UIImage(named: "l"))
            cell.team2Img.kf.setImage(with: URL(string:eventsViewModel.upcomingEventResponse[indexPath.row].away_team_logo!),placeholder: UIImage(named: "l"))
            cell.dateLabel.text=eventsViewModel.upcomingEventResponse[indexPath.row].event_date
            cell.timeLabel.text=eventsViewModel.upcomingEventResponse[indexPath.row].event_time
            cell.team1Name.text=eventsViewModel.upcomingEventResponse[indexPath.row].event_home_team
            cell.team2Name.text=eventsViewModel.upcomingEventResponse[indexPath.row].event_away_team
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "second", for: indexPath) as! SecondCollectionViewCell
            
            cell.layer.borderWidth=1
            cell.layer.borderColor=UIColor( red: 0.0, green: 0.268, blue:0.556, alpha: 1.0 ).cgColor
            cell.layer.cornerRadius = 5.0
            cell.layer.masksToBounds = false
            var scoreArray = eventsViewModel.latestResultResponse[indexPath.row].event_final_result?.split(separator: " - ")
            cell.team1Score.text = String(scoreArray![0])
            cell.team2Score.text = String(scoreArray![1])
            
            cell.team1Img.kf.setImage(with: URL(string:eventsViewModel.latestResultResponse[indexPath.row].home_team_logo!),placeholder: UIImage(named: "l"))
            cell.team2Img.kf.setImage(with: URL(string:eventsViewModel.latestResultResponse[indexPath.row].away_team_logo!),placeholder: UIImage(named: "l"))
            cell.dateLabel.text=eventsViewModel.latestResultResponse[indexPath.row].event_date
            cell.timeLabel.text=eventsViewModel.latestResultResponse[indexPath.row].event_time
            cell.team1Name.text=eventsViewModel.latestResultResponse[indexPath.row].event_home_team
            cell.team2Name.text=eventsViewModel.latestResultResponse[indexPath.row].event_away_team
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "third", for: indexPath) as! ThirdCollectionViewCell
            
            cell.layer.borderWidth=1
            cell.layer.borderColor=UIColor( red: 0.0, green: 0.268, blue:0.556, alpha: 1.0 ).cgColor
            cell.layer.cornerRadius = 5.0
            cell.layer.masksToBounds = false
            
            cell.teamImg.kf.setImage(with: URL(string:eventsViewModel.teamResponse[indexPath.row].team_logo ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRicMtQKsDDfklzvGcdWcD8rcHXcyeFQ0WEA&usqp=CAU"),placeholder: UIImage(named: "l"))
            cell.teamName.text=eventsViewModel.teamResponse[indexPath.row].team_name
            
            
            
            return cell
        }
    }

    class UpcomingEvents :UICollectionReusableView{
        let label = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            label.text="Upcoming Events"
            addSubview(label)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            label.frame=bounds
        }
        
    }
    class LatestResults :UICollectionReusableView{
        let label = UILabel()
       
        override init(frame: CGRect) {
            super.init(frame: frame)
            label.text="Latest Results"
            addSubview(label)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            label.frame=bounds
        }
        
    }
    class Teams :UICollectionReusableView{
        let label = UILabel()
       
        override init(frame: CGRect) {
            super.init(frame: frame)
            label.text="Teams"
            addSubview(label)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            label.frame=bounds
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "upcomingEvents" {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind ,withReuseIdentifier:   "upcomingEventsId", for: indexPath) as! UpcomingEvents
            return header
        }
        else  if kind == "latestResults" {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind ,withReuseIdentifier:   "latestResultsId", for: indexPath) as! LatestResults
            return header
        }
        else{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind ,withReuseIdentifier: "teamsId", for: indexPath) as! Teams
            return header
        }
    }
    
    func drawFirstSectionLayout()->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5
             , bottom: 0, trailing: 10)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .paging
        section.boundarySupplementaryItems = [
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: "upcomingEvents", alignment: .top),
        ]
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
             items.forEach { item in
                 let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                 let minScale: CGFloat = 0.9
             let maxScale: CGFloat = 1.0
             let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
             item.transform = CGAffineTransform(scaleX: scale, y: scale)
             }
        }
        return section
    }
    func drawSecondSectionLayout()->NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5
             , bottom: 20, trailing: 10)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: "latestResults", alignment: .top),
        ]
        
        return section
    }
    
    func drawThirdSectionLayout()->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
               , heightDimension: .fractionalHeight(1))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       
       let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(128)
       , heightDimension: .absolute(128))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
       , subitems: [item])
       group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
       , bottom: 0, trailing: 10)
       
       let section = NSCollectionLayoutSection(group: group)
       section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
       , bottom: 10, trailing: 15)
       section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: "teams", alignment: .top),
                ]
               
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section{
        case 2 :
            let teamDetails = storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamsDetailsViewController
            teamDetails.teamChosen=eventsViewModel.teamResponse[indexPath.row]
//            teamDetails.modalPresentationStyle = .fullScreen
//            teamDetails.modalTransitionStyle = .crossDissolve
            present(teamDetails, animated: true ,completion: nil)
        default:
            return
        }
    }
}
