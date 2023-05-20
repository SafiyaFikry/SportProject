//
//  FavViewController.swift
//  SportProject
//
//  Created by Mac on 19/05/2023.
//

import UIKit

class FavViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "FCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FCell") as! LeaguesTableViewCell
        return cell
    }
    
}
