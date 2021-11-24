//
//  DriverControlledViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 18/11/21.
//

import UIKit

class DriverControlledViewController: UIViewController {

    @IBOutlet weak var freight: UILabel!
    @IBOutlet weak var freight_l1: UILabel!
    @IBOutlet weak var freight_l2: UILabel!
    @IBOutlet weak var freight_l3: UILabel!
    @IBOutlet weak var shared_hub_freight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Keep the state like how it's saved in DataManager
        freight.text = String(DataManager.shared.freight)
        freight_l1.text = String(DataManager.shared.freight_l1)
        freight_l2.text = String(DataManager.shared.freight_l2)
        freight_l3.text = String(DataManager.shared.freight_l3)
        shared_hub_freight.text = String(DataManager.shared.shared_hub_freight)
    }
    
    //All of these below functions are used to set DataManager attributes
    @IBAction func freight_change(_ sender: UIStepper) {
        let changed_val: Int = Int(sender.value)
        freight.text = String(changed_val)
        DataManager.shared.freight = changed_val
    }
    @IBAction func feight_l1_change(_ sender: UIStepper) {
        let changed_val: Int = Int(sender.value)
        freight_l1.text = String(changed_val)
        DataManager.shared.freight_l1 = changed_val
    }
    @IBAction func freight_l2_change(_ sender: UIStepper) {
        let changed_val: Int = Int(sender.value)
        freight_l2.text = String(changed_val)
        DataManager.shared.freight_l2 = changed_val
    }
    @IBAction func freight_l3_change(_ sender: UIStepper) {
        let changed_val: Int = Int(sender.value)
        freight_l3.text = String(changed_val)
        DataManager.shared.freight_l3 = changed_val
    }
    @IBAction func shared_hub_freight_change(_ sender: UIStepper) {
        let changed_val: Int = Int(sender.value)
        shared_hub_freight.text = String(changed_val)
        DataManager.shared.shared_hub_freight = changed_val
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
