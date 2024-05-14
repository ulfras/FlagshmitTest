//
//  AppDelegate.swift
//  FlagsmithTest
//
//  Created by Maulana Frasha on 13/05/24.
//

import UIKit
import UnleashProxyClientSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var unleash = UnleashClient(
        unleashUrl: "https://app.unleash-hosted.com/demo/api/frontend",
        clientKey: "UnleashTest:development.3e833d3cc281bd4bea647da02edc1fe55b524516c12404bb90b3bbe8")
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        unleash.start()
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

