//
//  AddChallengeViewController.swift
//  SendBird-iOS
//
//  Created by Adib Thaqif on 5/8/20.
//  Copyright © 2020 SendBird. All rights reserved.
//

import UIKit

class AddChallengeViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var challengeNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //pass new challenge name to camera view controller
        if submitButton.isTouchInside{
            print("clicked")
            let detailsViewController = segue.destination as! CameraViewController
            detailsViewController.challenge = challengeNameField.text!
        }
        
    }
    
    func pressed(sender: UIButton!) -> Bool{
        return true
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
