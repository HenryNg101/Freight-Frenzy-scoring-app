//
//  AutonomousViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 18/11/21.
//

import UIKit

class AutonomousViewController: UIViewController {

    @IBOutlet weak var duck_delivered: UISwitch!
    @IBOutlet weak var parking_alliance_storage_unit: UISwitch!
    @IBOutlet weak var parking_storage_unit: UISwitch!
    @IBOutlet weak var parking_warehouse: UISwitch!
    @IBOutlet weak var completely_in_warehouse: UISwitch!
    @IBOutlet weak var freight_storage_unit: UISwitch!
    @IBOutlet weak var freight_shipping_hub: UISwitch!
    @IBOutlet weak var duck_used: UISwitch!
    @IBOutlet weak var team_scoring_elem_used: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        duck_delivered.setOn(DataManager.shared.duck_delivered, animated: false)
        parking_alliance_storage_unit.setOn(DataManager.shared.parking_alliance_storage_unit, animated: false)
        parking_storage_unit.setOn(DataManager.shared.parking_storage_unit, animated: false)
        parking_warehouse.setOn(DataManager.shared.parking_warehouse, animated: false)
        completely_in_warehouse.setOn(DataManager.shared.completely_in_warehouse, animated: false)
        freight_storage_unit.setOn(DataManager.shared.freight_storage_unit, animated: false)
        freight_shipping_hub.setOn(DataManager.shared.freight_shipping_hub, animated: false)
        duck_used.setOn(DataManager.shared.duck_used, animated: false)
        team_scoring_elem_used.setOn(DataManager.shared.team_scoring_elem_used, animated: false)
    }
    
    @IBAction func duck_delivered_change(_ sender: UISwitch) {
        DataManager.shared.duck_delivered = sender.isOn
    }
    @IBAction func parking_alliance_storage_unit_change(_ sender: UISwitch) {
        DataManager.shared.parking_alliance_storage_unit = sender.isOn
    }
    @IBAction func parking_storage_unit_change(_ sender: UISwitch) {
        DataManager.shared.parking_storage_unit = sender.isOn
    }
    @IBAction func parking_warehouse(_ sender: UISwitch) {
        DataManager.shared.parking_warehouse = sender.isOn
    }
    @IBAction func completely_in_warehouse_change(_ sender: UISwitch) {
        DataManager.shared.completely_in_warehouse = sender.isOn
    }
    @IBAction func freight_storage_unit_change(_ sender: UISwitch) {
        DataManager.shared.freight_storage_unit = sender.isOn
    }
    @IBAction func freight_shipping_hub_change(_ sender: UISwitch) {
        DataManager.shared.freight_shipping_hub = sender.isOn
    }
    @IBAction func duck_used_change(_ sender: UISwitch) {
        DataManager.shared.duck_used = sender.isOn
    }
    @IBAction func team_scoring_elem_used_change(_ sender: UISwitch) {
        DataManager.shared.team_scoring_elem_used = sender.isOn
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
