//
//  ScoreViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 18/11/21.
//
// For the final score view scene, submitting score to website, viewing and saving score.

import UIKit
import CoreLocation
import CoreData

class ScoreViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var autonomous_score: UILabel!
    @IBOutlet weak var driver_controlled_score: UILabel!
    @IBOutlet weak var endgame_score: UILabel!
    @IBOutlet weak var total_score: UILabel!
    @IBOutlet weak var submit_score: UIButton!
    @IBOutlet weak var result_noti: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var submit_question: UILabel!
    
    var locationManager: CLLocationManager!
    var location: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true

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
        
        //For taking location
        locationManager = CLLocationManager()
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
        
        //Only allow sharing for teams that choose allow sharing
        if !(DataManager.shared.selectedTeam?.allow_sharing ?? false) {
            submit_question.isHidden = true
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

    //When user want to submit high score to the website (Only available when user allow sharing at the beginning
    @IBAction func submit_score(_ sender: UIButton) {
        //loading Activity Indicator when user wait for result of upload score.
        spinner.isHidden = false
        spinner.startAnimating()
        
        let team_id: String = DataManager.shared.selectedTeam?.id ?? ""
        
        //URL encoding the location, since the user can enter anything here.
        var location: String = DataManager.shared.selectedTeam?.region ?? ""
        location = location.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        //API processing
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
                //Hide the activity indicator, then show result
                self.spinner.stopAnimating()
                
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
    
    //Take current location of user
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let user_location = locations[0] as CLLocation
 
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(user_location) { (placemarks, error) in
            if (error != nil) {
                print("Error in reverseGeocodeLocation")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count > 0 {
                let placemark = placemarks![0]
                
                self.location = ""
                self.location += placemark.name ?? ""
                self.location += ", "
                self.location += placemark.locality ?? ""
                self.location += ", "
                self.location += placemark.administrativeArea ?? ""
                self.location += " "
                self.location += placemark.postalCode ?? ""
                self.location += ", "
                self.location += placemark.country ?? ""
            }
        }
    }
    
    //Save all of user info: time, location, score, image.
    @IBAction func Saving_game_info(_ sender: UIButton) {
        //Take team info
        let team_id: String = DataManager.shared.selectedTeam?.id ?? ""
        let team_name: String = DataManager.shared.selectedTeam?.name ?? ""
        
        //Take the current time
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a dd/MM/yyyy"
        let time = formatter.string(from: date)
        
        //Saving data to Core Data
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Team_Scores", in: managedContext)
        let info = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        info.setValue(team_name, forKey: "teamName")
        info.setValue(team_id, forKey: "teamID")
        info.setValue(self.location, forKey: "location")
        info.setValue(endgame_score.text ?? "0", forKey: "endgame")
        info.setValue(driver_controlled_score.text ?? "0", forKey: "drivercontrolled")
        info.setValue(autonomous_score.text ?? "0", forKey: "autonomous")
        info.setValue(time, forKey: "created_time")
        
        do {
            try managedContext.save()
            DataManager.shared.teamscores.append(DataManager.TeamScores(team_id: team_id, name: team_name, autonomous: autonomous_score.text ?? "", drivercontrolled: driver_controlled_score.text ?? "0", endgame: endgame_score.text ?? "0", location: self.location, createdtime: time))
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
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
