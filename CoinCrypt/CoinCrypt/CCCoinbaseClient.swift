//
//  CCCoinbaseClient.swift
//  CoinCrypt
//
//  Created by MAIN on 6/12/17.
//  Copyright © 2017 CoinCrypt. All rights reserved.
//

import UIKit
import coinbase_official
import Firebase

class CCCoinbaseClient: NSObject {
    
    static let sharedInstance = CCCoinbaseClient()
    private override init() {} // This prevents others from using the default '()' initializer for this class.
    
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
                        NotificationCenter.default.post(name: .userDidAuthorizeCoinbase, object: nil)
                    }
                }
            }
        })
    }

}


extension Notification.Name {
    static let userDidAuthorizeCoinbase = Notification.Name("userDidAuthorizeCoinbase")
}
