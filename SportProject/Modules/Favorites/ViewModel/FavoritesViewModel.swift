//
//  FavoritesViewModel.swift
//  SportProject
//
//  Created by Mac on 30/05/2023.
//

import Foundation

class FavoritesViewModel{
    var list = [Item]()
    var manager : DCManagerFav
    init(manager:DCManagerFav){
        self.manager = manager
    }
    func getFavorites(){
        list = manager.retrieveAll()
    }
    func deleteFavorite(itemObj:Item){
        manager.deleteRow(itemObj: itemObj)
    }
}
