//
//  DCManagerFav.swift
//  SportProject
//
//  Created by Mac on 24/05/2023.
//

import Foundation
import UIKit
import CoreData

class DCManagerFav{
    static let instance = DCManagerFav()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext :NSManagedObjectContext!
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func insertRow(itemObj:Item){
        let entity = NSEntityDescription.entity(forEntityName: "FavTable", in: managedContext)
        let table = NSManagedObject(entity: entity!, insertInto: managedContext)
        table.setValue(itemObj.leagueId, forKey: "leagueId")
        table.setValue(itemObj.leagueName, forKey: "leagueName")
        table.setValue(itemObj.leagueLogo, forKey: "leagueLogo")
        table.setValue(itemObj.sportName, forKey: "sportName")
        do{
            try managedContext.save()
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func deleteRow(itemObj:Item){
        let row = fetchRow(item:itemObj)
        managedContext.delete(row[0])
        do{
            try managedContext.save()
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func deleteAll(){
        let rows = retrieveAll()
        for item in rows{
            let row=fetchRow(item:item)
            managedContext.delete(row[0])
            do{
                try managedContext.save()
            }
            catch let error as NSError{
                print(error.localizedDescription)
            }
        }
    }
    
    //leagueId   , leagueName    ,  leagueLogo    ,  sportName
    func retrieveAll()->[Item]{
        var result=[Item]()
        var arr:[NSManagedObject]!
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavTable")
        do{
            arr=(try managedContext.fetch(fetchRequest))
            for item in arr{
                result.append(Item(leagueId: item.value(forKey: "leagueId") as? Int, leagueName:item.value(forKey: "leagueName") as? String, leagueLogo: item.value(forKey: "leagueLogo") as? String, sportName: item.value(forKey: "sportName") as? String))
            }
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
        return result
    }
    
    
    func fetchRow(item:Item)->[NSManagedObject]{
        
        var arr:[NSManagedObject]!
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavTable")
        let myPredicate = NSPredicate(format: "leagueName == %@", item.leagueName!)
        fetchRequest.predicate=myPredicate
        do{
            arr=(try managedContext.fetch(fetchRequest))
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
        return arr
    }
    
    func isExist(item:Item)->Bool{
        
       var list = retrieveAll()
        for ele in list{
            if(ele.leagueName==item.leagueName){
                return true
            }
        }
        return false
    }
}
