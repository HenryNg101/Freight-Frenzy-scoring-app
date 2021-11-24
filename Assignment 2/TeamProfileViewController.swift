//
//  TeamProfileViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 24/11/21.
//
//

import UIKit

class TeamProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamID: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var robotName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.selected_team_scores.count
    }
    
    //Set the height of a table view cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 220

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamRecord", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        let team_record = DataManager.shared.selected_team_scores[indexPath.row]
        var result = "Game " + String(indexPath.row + 1)
        result += "\n\nAutonomous score: " + team_record.autonomous
        result += "\nDriver-controlled score: " + team_record.drivercontrolled
        result += "\nEnd-game score: " + team_record.endgame
        result += "\nWhen it was created: " + team_record.createdtime
        result += "\nWhere it was created: " + team_record.location
        cell.textLabel?.text = result
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        teamName.text = DataManager.shared.selectedTeam?.name
        teamID.text = DataManager.shared.selectedTeam?.id
        if DataManager.shared.selectedTeam?.region == "" {
            location.text = "N/A"
        }
        else{
            location.text = DataManager.shared.selectedTeam?.region
        }
        if DataManager.shared.selectedTeam?.robotName == "" {
            robotName.text = "N/A"
        }
        else{
            robotName.text = DataManager.shared.selectedTeam?.robotName
        }
        teamImage.image = UIImage(data: DataManager.shared.selectedTeam?.image ?? Data())
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
