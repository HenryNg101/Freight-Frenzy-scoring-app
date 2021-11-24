//
//  EndGameViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 18/11/21.
//

import UIKit

class EndGameViewController: UIViewController {

    @IBOutlet weak var ducks_delivered: UILabel!
    @IBOutlet weak var shared_hub_tipped: UISwitch!
    @IBOutlet weak var shipping_hub_balanced: UISwitch!
    @IBOutlet weak var shipping_hub_capped: UISwitch!
    @IBOutlet weak var end_parking_warehouse: UISwitch!
    @IBOutlet weak var end_completely_in_warehouse: UISwitch!
    
    var selected_record: DataManager.RegisterInfo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Keep the state like how it's saved in DataManager
        shared_hub_tipped.setOn(DataManager.shared.shared_hub_tipped, animated: false)
        shipping_hub_balanced.setOn(DataManager.shared.shipping_hub_balanced, animated: false)
        shipping_hub_capped.setOn(DataManager.shared.shipping_hub_capped, animated: false)
        end_parking_warehouse.setOn(DataManager.shared.end_parking_warehouse, animated: false)
        end_completely_in_warehouse.setOn(DataManager.shared.end_completely_in_warehouse, animated: false)
    }
    
    //All of these below functions are used to set DataManager attributes
    @IBAction func ducks_delivered_change(_ sender: UIStepper) {
        let changed_val: Int = Int(sender.value)
        ducks_delivered.text = String(changed_val)
        DataManager.shared.ducks_delivered = changed_val
    }
    @IBAction func shared_hub_tipped_change(_ sender: UISwitch) {
        DataManager.shared.shared_hub_tipped = sender.isOn
    }
    @IBAction func shipping_hub_balanced_change(_ sender: UISwitch) {
        DataManager.shared.shipping_hub_balanced = sender.isOn
    }
    @IBAction func shipping_hub_capped_change(_ sender: UISwitch) {
        DataManager.shared.shipping_hub_capped = sender.isOn
    }
    @IBAction func end_parking_warehouse_change(_ sender: UISwitch) {
        DataManager.shared.end_parking_warehouse = sender.isOn
    }
    @IBAction func end_completely_in_warehouse_change(_ sender: UISwitch) {
        DataManager.shared.end_completely_in_warehouse = sender.isOn
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
