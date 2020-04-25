//
//  LoginViewController.swift
//  Chally
//
//  Created by Adib Thaqif on 4/11/20.
//  Copyright © 2020 Adib Thaqif. All rights reserved.
//

import UIKit
import Parse
import SendBirdUIKit


class LoginViewController: UIViewController {
    var window: UIWindow?

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password){
            (user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                print("success logging in")
                
                let user = PFUser.current()
                print(user?.objectId)
                print(username)
                SBUGlobals.CurrentUser = SBUUser(userId: (user?.objectId!)!,nickname: username)
                SBUMain.connect { (user, error) in
                    guard error == nil else {   // Error.
                        return
                    }
                }
            }else{
                print("error logging in: \(error?.localizedDescription)")
                return
            }
        }
   
    }
       
    @IBAction func onSignUp(_ sender: Any) {
        // Initialize SendBird
        SBDMain.initWithApplicationId("7EF301FA-FD25-4096-8E46-B5111DEB4359")
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground{ (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                print("success signing up")
                SBUGlobals.CurrentUser = SBUUser(userId: user.objectId!,nickname: user.username)
                SBUMain.connect { (user, error) in
                    guard error == nil else {   // Error.
                        return
                    }
                }
            }else{
                print("error signing up: \(String(describing: error?.localizedDescription))" )
            }
            
        }
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if PFUser.current() != nil {
            print("current user available")
            let main = UIStoryboard(name: "Main", bundle: nil)
            let feedNavigationController = main.instantiateViewController(withIdentifier: "TabBarController")
            window?.rootViewController = feedNavigationController
            window?.makeKeyAndVisible()
        }else{
            print("no current user")
        }


        // Do any additional setup after loading the view.
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
