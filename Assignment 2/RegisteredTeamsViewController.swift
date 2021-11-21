//
//  RegisteredTeamsViewController.swift
//  Assignment 2
//
//  Created by user928878 on 11/21/21.
//

import UIKit

class RegisteredTeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var selected_team: DataManager.RegisterInfo? = nil
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_team = DataManager.shared.registered_profiles[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataManager.shared.registered_profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisteredProfile", for: indexPath)
        cell.textLabel?.text = DataManager.shared.registered_profiles[indexPath.row].name
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
