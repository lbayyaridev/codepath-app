//
//  AppDelegate.swift
//  Chally
//
//  Created by Adib Thaqif on 4/11/20.
//  Copyright © 2020 Adib Thaqif. All rights reserved.
//

import UIKit
import Parse
import SendBirdUIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Initialize Parse
               // Set applicationId and server based on the values in the Heroku settings.
        Parse.initialize(
                   with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                       configuration.applicationId = "Chally"
                       configuration.server = "https://ancient-anchorage-24331.herokuapp.com/parse"
                   })
               )
        
        if PFUser.current() != nil {
                   print("current user available")
                   let main = UIStoryboard(name: "Main", bundle: nil)
                   let feedNavigationController = main.instantiateViewController(withIdentifier: "TabBarController")
                   window?.rootViewController = feedNavigationController
                   window?.makeKeyAndVisible()
               }else{
                   print("no current user")
               }
        
        // Initialize SBUIkit
               let APP_ID = "7EF301FA-FD25-4096-8E46-B5111DEB4359"// The ID of the Sendbird application which UIKit sample app uses.
                  SBUMain.initialize(applicationId: APP_ID)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

