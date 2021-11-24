//
//  HighScoreTeamViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 20/11/21.
//

import UIKit

class HighScoreTeamViewController: UIViewController {

    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var team_id: UILabel!
    @IBOutlet weak var team_name: UILabel!
    @IBOutlet weak var created_time: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var teaam_image: UIImageView!
    @IBOutlet weak var autonomous: UILabel!
    @IBOutlet weak var driver_controlled: UILabel!
    @IBOutlet weak var endgame: UILabel!
    @IBOutlet weak var total_score: UILabel!
    
    func check_profile() -> DataManager.TeamInfo?{
        for profile in DataManager.shared.all_teams{
            if profile.id == DataManager.shared.selectedHighScoreTeam?.team_id {
                if profile.location != DataManager.shared.selectedHighScoreTeam?.location && DataManager.shared.selectedHighScoreTeam?.location == "" {
                    DataManager.shared.selectedHighScoreTeam?.location = profile.location
                }
                return profile
            }
        }
        return nil
    }
    
    //Same problem, it doesn't load up the first time, it always load the last click result
    override func viewDidLoad() {
        let profile = check_profile()
        let selected_record = DataManager.shared.selectedHighScoreTeam
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        id.text = selected_record?.id
        team_id.text = selected_record?.team_id
        team_name.text = profile?.name
        created_time.text = profile?.created_time
        location.text = selected_record?.location
        autonomous.text = selected_record?.autonomous_score
        driver_controlled.text = selected_record?.drivercontrolled_score
        endgame.text = selected_record?.endgame_score
        total_score.text = selected_record?.total_score
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
