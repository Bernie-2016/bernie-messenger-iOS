//
//  UIDevice+Utils.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import CoreTelephony
import MessageUI
import UIKit

extension UIDevice {
    
    var isHandset: Bool {
        return self.userInterfaceIdiom == .Phone
    }
    
    var isTablet: Bool {
        return self.userInterfaceIdiom == .Pad
    }
    
    var isSimulator: Bool {
        return self.model.containsString("Simulator")
    }
    
    var iOSVersion: Version {
        return Version(stringVersion: self.systemVersion)
    }
    
    func canMakeCalls() -> Bool {
        #if arch(i386) || arch(x86_64)
            return true
        #else
            if UIApplication.sharedApplication().canOpenURL(NSURL(string: "tel://")!) {
                if let networkCode = CTTelephonyNetworkInfo().subscriberCellularProvider?.mobileNetworkCode {
                    return !networkCode.isEmpty && networkCode != "65535"
                }
            }
            return false
        #endif
    }
    
    func canSendTexts() -> Bool {
        #if arch(i386) || arch(x86_64)
            return true
        #else
            return MFMessageComposeViewController.canSendText()
        #endif
    }
    
}
