//
//  ScoreViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 18/11/21.
//

import UIKit
import CoreLocation

class ScoreViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var autonomous_score: UILabel!
    @IBOutlet weak var driver_controlled_score: UILabel!
    @IBOutlet weak var endgame_score: UILabel!
    @IBOutlet weak var total_score: UILabel!
    @IBOutlet weak var submit_score: UIButton!
    @IBOutlet weak var result_noti: UILabel!
    
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
        
        //Only allow sharing for teams that choose allow sharing
        if !(DataManager.shared.selectedTeam?.allow_sharing ?? false) {
            submit_score.isEnabled = false
            submit_score.isHidden = true
        }
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

    //When user want to submit high score to the website
    @IBAction func submit_score(_ sender: UIButton) {
        let team_id: String = DataManager.shared.selectedTeam?.id ?? ""
        let location: String = DataManager.shared.selectedTeam?.region ?? ""
        print(team_id)
        print(location)
        var url_link: String = "https://www.partiklezoo.com/freightfrenzy/?action=addscore&teamid=" + team_id
        url_link += "&autonomous="
        url_link += autonomous_score.text ?? "0"
        url_link += "&drivercontrolled="
        url_link += driver_controlled_score.text ?? "0"
        url_link += "&endgame="
        url_link += endgame_score.text ?? "0"
        url_link += "&location="
        url_link += location
        print(url_link)
        let url = NSURL(string: url_link)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url! as URL, completionHandler:
            {(data, response, error) in
            if (error != nil) { return; }
            if let json = try? JSON(data: data!) {
                if json["result"].string! == "error" {
                    self.result_noti.text = "Can't submit high score, " + json["message"].string!
                }
                else {
                    self.result_noti.text = "Successfully submitted the score, " + json["action"].string!
                }
            }
        })
        task.resume()
    }
    
    @IBAction func location_printing(_ sender: UIButton) {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("Loction Enabled")
            locationManager.startUpdatingLocation()
        }
        else {
            print("Location is not enabled")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let user_location = locations[0] as CLLocation
        let latitude = user_location.coordinate.latitude
        let longtitude = user_location.coordinate.longitude
        print(latitude)
        print(longtitude)
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(user_location) { (placemarks, error) in
            if (error != nil) {
                print("Error in reverseGeocodeLocation")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count > 0 {
                let placemark = placemarks![0]
                
                let locality = placemark.locality
                let admistrativeArea = placemark.administrativeArea
                let country = placemark.country
                print(locality)
                print(admistrativeArea)
                print(country)
            }
        }
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
