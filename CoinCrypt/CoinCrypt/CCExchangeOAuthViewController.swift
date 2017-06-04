//
//  CCExchangeOAuthViewController.swift
//  CoinCrypt
//
//  Created by Connor Dunham on 5/31/17.
//  Copyright © 2017 CoinCrypt. All rights reserved.
//

import UIKit
import coinbase_official
import Firebase


class CCExchangeOAuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func connectCoinbaseButtonPressed(_ sender: Any) {
        let clientID = FIRRemoteConfig.remoteConfig()[coinbase_client_id].stringValue
        CoinbaseOAuth.startAuthentication(withClientId: clientID, scope: "user balance", redirectUri: "com.coincrypt.coincrypt.coinbase-oauth://coinbase_oauth", meta: nil)
    }
    
    @IBAction func declineCoinbaseButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "exchangeOAuth_mainScreen", sender: self)
    }
    
    func handleCoinbaseOAuthRedirect(_ url: URL) -> Void {
        let clientID = FIRRemoteConfig.remoteConfig()[coinbase_client_id].stringValue
        let clientSecret = FIRRemoteConfig.remoteConfig()[coinbase_client_secret].stringValue
        CoinbaseOAuth.finishAuthentication(for: url, clientId: clientID, clientSecret: clientSecret, completion: { (result: Any?, error: Error?) in
            if error != nil {
                print("Coinbase OAuth failure")
            }
            else {
                print("Coinbase Oauth success")
                if let result = result as? [String : AnyObject] {
                    if let accessToken = result["access_token"] as? String {
                        
                    }
                }
            }
        })
    }
}
