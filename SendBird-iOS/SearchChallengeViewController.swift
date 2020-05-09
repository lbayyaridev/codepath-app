//
//  SearchChallengeViewController.swift
//  SendBird-iOS
//
//  Created by Adib Thaqif on 5/7/20.
//  Copyright © 2020 SendBird. All rights reserved.
//

import UIKit
import Parse

class SearchChallengeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    var challengeArray:[String] = []
    var searchChallenge:[String] = []
    var searching = false
    
    //TODO: filter to only global posts and posts from groups that you are in
    func loadArray(){
        let query = PFQuery(className:"Posts")
        query.whereKey("local", equalTo: false)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) posts.")
                // Do something with the found objects
                for object in objects {
                    let challenge = object["challenge"] as! String
                    self.challengeArray.append(challenge)
                    self.tableView.reloadData()
                    
                }
                print(self.challengeArray)
                
            }
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchChallenge = challengeArray.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArray()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchChallenge.count
        }else{
            return challengeArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")
        //print(indexPath.row)
        if searching{
            cell?.textLabel?.text = searchChallenge[indexPath.row]
        }else{
            cell?.textLabel?.text = challengeArray[indexPath.row]
        }
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //find selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        var challenge = ""
        if searching{
            challenge = searchChallenge[indexPath.row]
        }else{
            challenge = challengeArray[indexPath.row]
        }
        
        //pass selected movie to the details view controller
        let detailsViewController = segue.destination as! CameraViewController
        detailsViewController.challenge = challenge
        
        //deselect
        tableView.deselectRow(at: indexPath, animated: true)
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
