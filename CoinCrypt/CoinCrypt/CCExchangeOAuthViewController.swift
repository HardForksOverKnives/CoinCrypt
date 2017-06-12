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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(forName: .userDidAuthorizeCoinbase, object: nil, queue: OperationQueue.main) { (Notification) in
            self.performSegue(withIdentifier: "exchangeOAuth_mainScreen", sender: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }


    @IBAction func connectCoinbaseButtonPressed(_ sender: Any) {
        let clientID = FIRRemoteConfig.remoteConfig()[coinbase_client_id].stringValue
        CoinbaseOAuth.startAuthentication(withClientId: clientID, scope: "user balance", redirectUri: "com.coincrypt.coincrypt.coinbase-oauth://coinbase_oauth", meta: nil)
    }
    
    @IBAction func declineCoinbaseButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "exchangeOAuth_mainScreen", sender: self)
    }
    
}
