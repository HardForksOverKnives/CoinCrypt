//
//  AppDelegate.swift
//  CoinCrypt
//
//  Created by Connor Dunham on 5/1/17.
//  Copyright © 2017 CoinCrypt. All rights reserved.
//

import UIKit
import Firebase
import coinbase_official
import CocoaLumberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        // setup logging
        CCCocoaLumberJackManager.setup()
        
        FIRApp.configure()
        let remoteConfig = FIRRemoteConfig.remoteConfig()
        let remoteConfigSettings = FIRRemoteConfigSettings(developerModeEnabled: true)
        remoteConfig.configSettings = remoteConfigSettings!
        remoteConfig.setDefaultsFromPlistFileName("RemoteConfigDefaults")
        
        remoteConfig.fetch(withExpirationDuration: 20) { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                remoteConfig.activateFetched()
            } else {
                print("Config not fetched")
                print("Error \(error!.localizedDescription)")
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if (CoinbaseOAuth.isAppOAuthAuthenticationAvailable())
        {
            let vc = storyboard.instantiateViewController(withIdentifier: "CCExchangeOAuthViewController")
            self.window?.rootViewController = vc
        }
        else
        {
            let vc = storyboard.instantiateViewController(withIdentifier: "homeScreen")
            self.window?.rootViewController = vc
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == "com.coincrypt.coincrypt.coinbase-oauth" {
            let ccExchangeVC = self.window?.rootViewController as! CCExchangeOAuthViewController
            ccExchangeVC.handleCoinbaseOAuthRedirect(url)
            return true
        }
        else {
            return false
        }
    }
}

