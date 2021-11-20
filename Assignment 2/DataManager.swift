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
    
    //Team info (For registering)
    var
    
    //High scores
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
    
    override init() {
        super.init()
    }
    
    func addteamInfo() {
        
    }
    
    func loadTeamInfosFromData(){
        
    }
}
