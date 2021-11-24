//
//  TeamProfilesViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 24/11/21.
//

import UIKit

class TeamProfilesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataManager.shared.selectedTeam = DataManager.shared.registered_profiles[indexPath.row]
        DataManager.shared.selected_team_scores = []
        for team_record in DataManager.shared.teamscores {
            if team_record.team_id == DataManager.shared.selectedTeam?.id && team_record.name == DataManager.shared.selectedTeam?.name {
                DataManager.shared.selected_team_scores.append(team_record)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.registered_profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamProfile", for: indexPath)
        cell.textLabel?.text = DataManager.shared.registered_profiles[indexPath.row].id
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
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
