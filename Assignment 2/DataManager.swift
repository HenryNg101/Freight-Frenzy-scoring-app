//
//  DataManager.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 18/11/21.
//
// This file is used to manage all of data, and allow singleton, to keep data intact when using application

import UIKit
import CoreData

class DataManager: NSObject {
    static let shared = DataManager()
    //Total score for a game
    var total_score: Int = 0
    var autonomous_score: Int = 0
    var driver_controlled_score: Int = 0
    var endgame_score: Int = 0
    
    //Stage 1 score components
    var duck_delivered: Bool = false
    var parking_alliance_storage_unit: Bool = false
    var parking_storage_unit: Bool = false
    var parking_warehouse: Bool = false
    var completely_in_warehouse: Bool = false
    var freight_storage_unit: Bool = false
    var freight_shipping_hub: Bool = false
    var duck_used: Bool = false
    var team_scoring_elem_used: Bool = false
 
    //Stage 2 score components
    var freight: Int = 0
    var freight_l1: Int = 0
    var freight_l2: Int = 0
    var freight_l3: Int = 0
    var shared_hub_freight: Int = 0
    
    //Stage 3 score components
    var ducks_delivered: Int = 0
    var shared_hub_tipped: Bool = false
    var shipping_hub_balanced: Bool = false
    var shipping_hub_capped: Bool = false
    var end_parking_warehouse: Bool = false
    var end_completely_in_warehouse: Bool = false
    
    //Team info (When registering)
    struct RegisterInfo {
        var name: String
        var id: String
        var region: String
        var robotName: String
        var image: Data
        var allow_sharing: Bool
    }
    var registered_profiles: [RegisterInfo] = []
    
    //Selected registered team and team in high score list
    var selectedTeam: RegisterInfo? = nil
    var selectedHighScoreTeam: HighScoreTeam? = nil
    
    //High scores and team info collected from the web API (not the one registered in the app)
    //One more note, there are more teams in total than teams in highscore list (427 vs 100)
    struct TeamInfo {
        var id: String
        var name: String
        var image: String?
        var created_time: String
        var location: String //If this and HighScoreTeam's one are not sync, I'll leave this blank.
    }
    struct HighScoreTeam {
        var id: String
        var team_id: String     //Real team id
        var autonomous_score: String
        var drivercontrolled_score: String
        var endgame_score: String
        var total_score: String
        var location: String? //If this and TeamInfo's one are not sync, I'll leave this blank
    }
    var high_scores: [HighScoreTeam] = []
    var all_teams: [TeamInfo] = []
    
    //All registered team's scores
    struct TeamScores {
        var team_id: String
        var name: String
        var autonomous: String
        var drivercontrolled: String
        var endgame: String
        var location: String
        var createdtime: String
    }
    var teamscores: [TeamScores] = []
    var selected_team_scores: [TeamScores] = []
    
    //Context for the Core Data
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override init() {
        super.init()
        print(type(of: DataManager.RegisterInfo.self))
        
        loadTeamInfosFromCoreData()
        //deleteAllInfo()
    }
    
    //This function is only used when I need to reset my database, for testing and development. So, whenever the core data is messed up, choose the entity in entityName attribute in NSFetchRequest(), call this method in init() and its done.
    func deleteAllInfo() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Team_Scores")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.persistentStoreCoordinator?.execute(deleteRequest, with: managedContext)
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    //Register new team, add the new team to the Core Data
    func addteamInfo(teamName: String, teamID: String, location: String, robotName: String, image: Data, allow_sharing: Bool) {
        var newInfo = RegisterInfo(name: teamName, id: teamID, region: location, robotName: robotName, image: image, allow_sharing: allow_sharing)
        //Reset info to more exact and specific info
        if newInfo.region == "" {
            newInfo.region = "N/A"
        }
        if newInfo.robotName == "" {
            newInfo.robotName = "N/A"
        }
        if newInfo.image == UIImage(named: "upload_image.png")?.pngData() {
            newInfo.image = UIImage(named: "not_available_img.png")?.pngData() ?? Data()
        }
        
        //Add new team info to the Core Data
        let entity = NSEntityDescription.entity(forEntityName: "Team_Info", in: managedContext)
        let info = NSManagedObject(entity: entity!, insertInto: managedContext)
        info.setValue(newInfo.image, forKey: "image")
        info.setValue(newInfo.region, forKey: "region")
        info.setValue(newInfo.robotName, forKey: "robotName")
        info.setValue(newInfo.id, forKey: "teamID")
        info.setValue(newInfo.name, forKey: "teamName")
        info.setValue(newInfo.allow_sharing, forKey: "allow_sharing")
            
        do {
            try managedContext.save()
            registered_profiles.append(newInfo)
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //Load all data from Core Data to DataManager attribute
    func loadTeamInfosFromCoreData(){
        
        //Load all of registered teams
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team_Info")
        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results {
                let record = result as! NSManagedObject
                
                //Load data from Core Data
                registered_profiles.append(RegisterInfo(name: record.value(forKey: "teamName") as! String, id: record.value(forKey: "teamID") as! String, region: record.value(forKey: "region") as! String, robotName: record.value(forKey: "robotName") as! String, image: record.value(forKey: "image") as! Data, allow_sharing: record.value(forKey: "allow_sharing") as! Bool))
            }
        }
        catch let error as NSError {
            print("Could not load. \(error), \(error.userInfo)")
        }
        
        //Load all team's scores, for every team, every time they play a game
        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team_Scores")
        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results {
                let record = result as! NSManagedObject

                //Load data from Core Data
                teamscores.append(TeamScores(team_id: record.value(forKey: "teamID") as! String, name: record.value(forKey: "teamName") as! String, autonomous: record.value(forKey: "autonomous") as! String, drivercontrolled: record.value(forKey: "drivercontrolled") as! String, endgame: record.value(forKey: "endgame") as! String, location: record.value(forKey: "location") as! String, createdtime: record.value(forKey: "created_time") as! String))
            }
        }
        catch let error as NSError {
            print("Could not load. \(error), \(error.userInfo)")
        }
    }
}
