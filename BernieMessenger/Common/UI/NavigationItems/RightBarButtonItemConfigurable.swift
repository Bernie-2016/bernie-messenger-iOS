//
//  RightBarButtonItemConfigurable.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/13/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

enum RightBarButtonItemType {
    
    case None
    case Cancel
    case Close
    case Custom(UIBarButtonItem)
    
}

// MARK: RightBarButtonItemConfigurable

protocol RightBarButtonItemConfigurable : class {
    
    var rightBarButtonItemType: RightBarButtonItemType { get }
    
}

// MARK: Default implementation for controllers

extension RightBarButtonItemConfigurable where Self : UIViewController {
    
    func setUpRightBarButtonItem() {
        clearCurrentRightBarButtonItem()
        
        var rightBarButtonItems: [UIBarButtonItem] = []
        
        switch self.rightBarButtonItemType {
        case .None:
            break
        case .Cancel:
            rightBarButtonItems.append(cancelBarButtonItem())
        case .Close:
            rightBarButtonItems.append(closeBarButtonItem())
        case .Custom(let barButtonItem):
            rightBarButtonItems.append(barButtonItem)
        }
        
        self.navigationItem.rightBarButtonItems = rightBarButtonItems
    }
    
    private func cancelBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(title: "Cancel", style: .Plain, target: self.navigationController, action: #selector(UINavigationController.cancelButtonAction))
    }
    
    private func closeBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(title: "Close", style: .Plain, target: self.navigationController, action: #selector(UINavigationController.cancelButtonAction))
    }
    
    private func clearCurrentRightBarButtonItem() {
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.rightBarButtonItems = []
    }
    
}

// MARK: Button action handling

extension UINavigationController {
    
    func cancelButtonAction() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
