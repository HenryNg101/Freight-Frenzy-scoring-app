//
//  HighScoreViewController.swift
//  Assignment 2
//
//  Created by Nguyen, Quoc Hung - nguqy034 on 19/11/21.
//

import UIKit

class HighScoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureCollectionView()
    }
    
    func configureCollectionView()
    {
       collectionView!.dataSource = self
       collectionView!.delegate = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return DataManager.shared.AllHighScores.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Score", for: indexPath) as! TeamName
          cell.textView.text = DataManager.shared.highscores[indexPath.row]
          return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
