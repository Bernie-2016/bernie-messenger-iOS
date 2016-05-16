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
    
    func willPerformBlockingCall(loadingMessage loadingMessage: String?, businessService: BusinessService)
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
