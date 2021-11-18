//
//  ScoreViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 18/11/21.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var autonomous_score: UILabel!
    @IBOutlet weak var driver_controlled_score: UILabel!
    @IBOutlet weak var endgame_score: UILabel!
    @IBOutlet weak var total_score: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let data_obj: DataManager = DataManager.shared
        let autonomous: Int = calculate_autonomous(data_obj)
        let driver_controlled: Int = calculate_driver_controlled(data_obj)
        let endgame: Int = calculate_endgame(data_obj)
        let total: Int = autonomous + driver_controlled + endgame
        data_obj.autonomous_score = autonomous
        data_obj.driver_controlled_score = driver_controlled
        data_obj.endgame_score = endgame
        data_obj.total_score = total
        autonomous_score.text = String(autonomous)
        driver_controlled_score.text = String(driver_controlled)
        endgame_score.text = String(endgame)
        total_score.text = String(total)
    }
    
    //Translate all of those option to integer (0 or 1), then multiply by the provided score, then calculate the sum
    func calculate_autonomous(_ data: DataManager) -> Int{
        let duck_delivered_score = (data.duck_delivered ? 1 : 0) * 10
        let parking_alliance_storage_unit_score = (data.parking_alliance_storage_unit ? 1 : 0)*3
        let parking_storage_unit_score = (data.parking_storage_unit ? 1 : 0)*6
        let parking_warehouse_score = (data.parking_warehouse ? 1 : 0)*5
        let completely_in_warehouse_score = (data.completely_in_warehouse ? 1 : 0)*10
        let freight_storage_unit_score = (data.freight_storage_unit ? 1 : 0)*2
        let freight_shipping_hub_score = (data.freight_shipping_hub ? 1 : 0)*6
        let duck_used_score = (data.duck_used ? 1 : 0)*10
        let team_scoring_elem_used_score = (data.team_scoring_elem_used ? 1 : 0)*20
        return duck_delivered_score + parking_alliance_storage_unit_score + parking_storage_unit_score + parking_warehouse_score + completely_in_warehouse_score + freight_storage_unit_score + freight_shipping_hub_score + duck_used_score + team_scoring_elem_used_score
    }
    
    func calculate_driver_controlled(_ data: DataManager) -> Int {
        return data.freight + data.freight_l1 + data.freight_l2 + data.freight_l3 + data.shared_hub_freight
    }
    
    func calculate_endgame(_ data: DataManager) -> Int {
        let shared_hub_tipped_score = (data.shared_hub_tipped ? 1 : 0) * 20
        let shipping_hub_balanced_score = (data.shipping_hub_balanced ? 1 : 0) * 10
        let shipping_hub_capped_score = (data.shipping_hub_capped ? 1 : 0) * 15
        let end_parking_warehouse_score = (data.end_parking_warehouse ? 1 : 0) * 3
        let end_completely_in_warehouse_score = (data.end_completely_in_warehouse ? 1 : 0) * 6
        return shared_hub_tipped_score + shipping_hub_balanced_score + shipping_hub_capped_score + end_parking_warehouse_score + end_completely_in_warehouse_score + data.ducks_delivered
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
