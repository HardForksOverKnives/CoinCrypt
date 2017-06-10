//
//  CCCocoaLumberJackManager.swift
//  CoinCrypt
//
//  Created by Connor Dunham on 6/6/17.
//  Copyright © 2017 CoinCrypt. All rights reserved.
//

import UIKit
import CocoaLumberjack



class CCCocoaLumberJackManager: NSObject {

    #if DEBUG
    static let logLevel = DDLogLevel.verbose
    #else
    static let logLevel = DDLogLevel.warning
    #endif
    
    class func setup() -> Void {
        DDLog.add(DDTTYLogger.sharedInstance, with: logLevel) // TTY = Xcode console
        DDLog.add(DDASLLogger.sharedInstance, with: logLevel) // ASL = Apple System Logs
        
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
    
}
