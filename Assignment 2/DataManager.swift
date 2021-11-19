//
//  DataManager.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 18/11/21.
//

import UIKit
import CoreData

class DataManager: NSObject {
    static let shared = DataManager()
    //Total score
    var total_score: Int = 0
    var autonomous_score: Int = 0
    var driver_controlled_score: Int = 0
    var endgame_score: Int = 0
    
    //Stage 1
    var duck_delivered: Bool = false
    var parking_alliance_storage_unit: Bool = false
    var parking_storage_unit: Bool = false
    var parking_warehouse: Bool = false
    var completely_in_warehouse: Bool = false
    var freight_storage_unit: Bool = false
    var freight_shipping_hub: Bool = false
    var duck_used: Bool = false
    var team_scoring_elem_used: Bool = false
 
    //Stage 2
    var freight: Int = 0
    var freight_l1: Int = 0
    var freight_l2: Int = 0
    var freight_l3: Int = 0
    var shared_hub_freight: Int = 0
    
    //Stage 3
    var ducks_delivered: Int = 0
    var shared_hub_tipped: Bool = false
    var shipping_hub_balanced: Bool = false
    var shipping_hub_capped: Bool = false
    var end_parking_warehouse: Bool = false
    var end_completely_in_warehouse: Bool = false
    
    //Team info
    var addedteamName: String = ""
    var addedteamID: Int = 0
    var addedlocation: String = ""
    var addedimageView: UIImageView = UIImageView()
    struct TeamInfo: Equatable {    //Allow different TeamInfo struct objects to be compared
        var teamName: String
        var teamID: Int
        var location: String
        var imageView: UIImageView
    }
    var AllTeamInfos = [TeamInfo]()
    
    override init() {
        super.init()
        
        let url = NSURL(string: "http://www.partiklezoo.com/freightfrenzy/?")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url! as URL, completionHandler:
            {(data, response, error) in
            if (error != nil) { return; }
            if let json = try? JSON(data: data!) {
                for count in 0...json.count - 1 {
                    print(json[count]["score"].string!)
                }
            }
        })
        task.resume()
    }
    
    func addTeamInfo(teaminfo: TeamInfo){
        var exist_check: Bool = false
        for TeamInfo in AllTeamInfos {
            if (teaminfo.teamID == TeamInfo.teamID) && (teaminfo.teamName == TeamInfo.teamName) {
                exist_check = true
            }
        }
        if (!AllTeamInfos.contains(teaminfo)) && !exist_check {
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "Team_Info", in: managedContext)
            
            let teaminfodata = NSManagedObject(entity: entity!, insertInto: managedContext)
            teaminfodata.setValue(teaminfo.imageView, forKey: "image")
            teaminfodata.setValue(teaminfo.location, forKey: "location")
            teaminfodata.setValue(teaminfo.teamID, forKey: "teamID")
            teaminfodata.setValue(teaminfo.teamName, forKey: "teamName")
            
            do {
                try managedContext.save()
                AllTeamInfos.append(teaminfo)
            }
            catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        else {
            print("Information entered already")
        }
    }
    
    func loadTeamInfoFromData(){
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team_Info")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results {
                let record = result as! NSManagedObject
                let element: TeamInfo = TeamInfo(teamName: record.value(forKey: "teamName") as! String, teamID: record.value(forKey: "teamID") as! Int, location: record.value(forKey: "location") as! String, imageView: record.value(forKey: "image") as! UIImageView)
                print(element)
                AllTeamInfos.append(element)
            }
        }
        catch let error as NSError {
            print("Could not load. \(error), \(error.userInfo)")
        }
    }
}
