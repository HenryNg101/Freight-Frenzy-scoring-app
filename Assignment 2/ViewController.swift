//
//  ViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 18/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        //Load all high scores right before the view is loaded
        //There's a problem here, when I try open the high score page at first, it doesn't load, it only loads up at 2nd time
        var url = NSURL(string: "http://www.partiklezoo.com/freightfrenzy/?")
        let config = URLSessionConfiguration.default
        var session = URLSession(configuration: config)
        var task = session.dataTask(with: url! as URL, completionHandler:
            {(data, response, error) in
            if (error != nil) { return; }
            if let json = try? JSON(data: data!) {
                for count in 0...json.count - 1 {
                    let element = json[count]
                    DataManager.shared.high_scores.append(DataManager.HighScoreTeam(id: element["id"].string!, team_id: element["teamid"].string!, autonomous_score: element["autonomous"].string!, drivercontrolled_score: element["drivercontrolled"].string!, endgame_score: element["endgame"].string!, total_score: element["score"].string!, location: element["location"].string ?? ""))
                }
            }
        })
        task.resume()
        
        //All teams, include the one that has no high score.
        url = NSURL(string: "http://www.partiklezoo.com/freightfrenzy/?action=teams")
        session = URLSession(configuration: config)
        task = session.dataTask(with: url! as URL, completionHandler:
            {(data, response, error) in
            if (error != nil) { return; }
            if let json = try? JSON(data: data!) {
                for count in 0...json.count - 1 {
                    let element = json[count]
                    DataManager.shared.all_teams.append(DataManager.TeamInfo(id: element["id"].string!, name: element["name"].string!, image: element["image"].string ?? "", created_time: element["created"].string!, location: element["location"].string!))
                }
            }
        })
        task.resume()
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


}

