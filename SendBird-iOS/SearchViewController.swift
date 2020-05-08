//
//  SearchViewController.swift
//  SendBird-iOS
//
//  Created by Adib Thaqif on 5/7/20.
//  Copyright © 2020 SendBird. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
   
    var challenges = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = PFQuery(className: "Posts")
        query.includeKey("challenge")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) posts")
                // Do something with the found objects
                var count = 0;
                for object in objects {
                    let challenge = object["challenge"] as! String
                    self.challenges.insert(challenge, at: count)
                    //print(challenge)
                    count+=1
                    //let challengeName = object as String
                    //challenges.insert(challengeName)
                }
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")
        cell?.textLabel?.text = challenges[indexPath.row]
        print("challenge: \(challenges[indexPath.row]) ")
        return cell!
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
