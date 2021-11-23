//
//  HighScoreViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 20/11/21.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var teamid_list = [String]()
    var filtered_teamid = [String]()
    var searching = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataManager.shared.selectedHighScoreTeam = DataManager.shared.high_scores[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filtered_teamid.count
        }
        else {
            return DataManager.shared.high_scores.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreCell", for: indexPath)
        if searching {
            cell.textLabel?.text = filtered_teamid[indexPath.row]
        }
        else {
            cell.textLabel?.text = String(indexPath.row) + "            " + DataManager.shared.high_scores[indexPath.row].id
        }
        return cell
    }
    
    var searchTeam = [String]()
    
    //Override search bar functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered_teamid = teamid_list.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
    }
    
    override func viewDidLoad() {        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for element in DataManager.shared.high_scores {
            teamid_list.append(element.team_id)
        }
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
