//
//  AppDelegate.swift
//  FlagsmithTest
//
//  Created by Maulana Frasha on 13/05/24.
//

import UIKit
import FlagsmithClient

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Flagsmith.shared.apiKey = "BSKcqbUQzBNnHusVocYf6d"
        Flagsmith.shared.getFeatureFlags() { (result) in
            switch result {
            case .success(let flags):
                for flag in flags {
                    let name = flag.feature.name
                    let value = flag.value.stringValue
                    let enabled = flag.enabled
                    print(name, "= enabled:", enabled, "value:", value ?? "nil")
                }
            case .failure(let error):
                print(error)
            }
        }
        
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
