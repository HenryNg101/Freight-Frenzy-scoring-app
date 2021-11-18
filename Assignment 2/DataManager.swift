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
    
    /*
    var scores: Int {
        get {return score}
        set(newScore){
            score = newScore
        }
    }
    
    //Setter and getter for stage 1
    var stage1_check: [Bool] {
        get {return [duck_delivered, parking_alliance_storage_unit, parking_storage_unit, parking_warehouse, completely_in_warehouse, freight_storage_unit, freight_shipping_hub, duck_used, team_scoring_elem_used]}
        set(newVal){
            duck_delivered = newVal[0]
            parking_alliance_storage_unit = newVal[1]
            parking_storage_unit = newVal[2]
            parking_warehouse = newVal[3]
            completely_in_warehouse = newVal[4]
            freight_storage_unit = newVal[5]
            freight_shipping_hub = newVal[6]
            duck_used = newVal[7]
            team_scoring_elem_used = newVal[8]
        }
    }
    
    //Setter and getter for stage 2
    var stage2_val: [Int] {
        get {return [freight, freight_l1, freight_l2, freight_l3, shared_hub_freight]}
        set(newVal){
            freight = newVal[0]
            freight_l1 = newVal[1]
            freight_l2 = newVal[2]
            freight_l3 = newVal[3]
            shared_hub_freight = newVal[4]
        }
    }
    
    //Setter and getter for stage 3
    var stage3_val: Int {
        get {return ducks_delivered}
        set(newVal){
            ducks_delivered = newVal
        }
    }
    
    var stage3_check: [Bool] {
        get {return [shared_hub_tipped, shipping_hub_balanced, shipping_hub_capped, end_parking_warehouse, end_completely_in_warehouse]}
        set(newVal){
            shared_hub_tipped = newVal[0]
            shipping_hub_balanced = newVal[1]
            shipping_hub_capped = newVal[2]
            end_parking_warehouse = newVal[3]
            end_completely_in_warehouse = newVal[4]
        }
    }*/
    
    override init() {
        super.init()
    }
}
