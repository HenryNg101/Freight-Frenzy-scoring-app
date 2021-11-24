//
//  HighScoreViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 20/11/21.
//
// Used to display all high scores and search for high score

import UIKit

class HighScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var searchTeamID = [String]()
    var searching = false           //Notify when the table is in search or not
    var teamid_list = [String]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataManager.shared.selectedHighScoreTeam = DataManager.shared.high_scores[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchTeamID.count
        }
        else {
            return DataManager.shared.high_scores.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreCell", for: indexPath)
        if searching {
            cell.textLabel?.text = String(indexPath.row) + "            " + searchTeamID[indexPath.row]
        }
        else {
            cell.textLabel?.text = String(indexPath.row) + "            " + DataManager.shared.high_scores[indexPath.row].id
        }
        return cell
    }
    
    var searchTeam = [String]()
    
    //Override search bar functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTeamID = teamid_list.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for element in DataManager.shared.high_scores {
            teamid_list.append(element.id)
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
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
