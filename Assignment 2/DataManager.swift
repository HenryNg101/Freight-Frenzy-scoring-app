//
//  DataManager.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 18/11/21.
//

import UIKit

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
}
