//
//  BusinessServiceUIDelegate.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 5/15/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import MBProgressHUD
import UIKit

protocol BusinessServiceUIDelegate : class {
    
    /**
     Method that will be called whenever a business service is about to perform a blocking
     call. Any UI that needs to be updated to communicate that the app is waiting should
     be done inside this method.
     
     - parameter businessService: The business service that initiated the blocking call
     - parameter loadingMessage: Optional message to show beneath loading indicator
     */
    func willPerformBlockingCall(loadingMessage loadingMessage: String?, businessService: BusinessService)
    
    /**
     Method that will be called whenever a business service completes a blocking call.
     Any UI updates that need to be done to enable the UI should be done inside this
     method.
     
     - parameter businessService: The business service that initiated the blocking call
     */
    func didFinishBlockingCall(businessService businessService: BusinessService)
    
}

// MARK: View controller conformance

extension UIViewController : BusinessServiceUIDelegate {
    
    func willPerformBlockingCall(loadingMessage loadingMessage: String? = nil, businessService: BusinessService) {
        guard let window = UIApplication.sharedApplication().keyWindow else {
            return
        }
        
        let hud = MBProgressHUD.showHUDAddedTo(window, animated: true)
        hud.label.text = loadingMessage
    }
    
    func didFinishBlockingCall(businessService businessService: BusinessService) {
        guard let window = UIApplication.sharedApplication().keyWindow else {
            return
        }
        
        MBProgressHUD.hideHUDForView(window, animated: true)
    }
    
}
