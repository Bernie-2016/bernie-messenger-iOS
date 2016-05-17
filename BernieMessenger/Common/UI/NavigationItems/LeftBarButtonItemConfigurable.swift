//
//  LeftBarButtonItemConfigurable.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/13/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Font_Awesome_Swift
import UIKit

enum LeftBarButtonItemType {
    
    case None
    case Back
    
}

// MARK: LeftBarButtonItemConfigurable

protocol LeftBarButtonItemConfigurable : class {
    
    var leftBarButtonItemType: LeftBarButtonItemType { get }
    
}

// MARK: Default implementation for controllers

extension LeftBarButtonItemConfigurable where Self : UIViewController {
    
    func setUpLeftBarButtonItem() {
        clearCurrentLeftBarButtonItems()
        
        var leftBarButtonItems: [UIBarButtonItem] = []
        
        switch self.leftBarButtonItemType {
        case .None:
            break
        case .Back:
            leftBarButtonItems.append(backBarButtonItem())
        }
        
        self.navigationItem.leftBarButtonItems = leftBarButtonItems
    }
    
    private func backBarButtonItem() -> UIBarButtonItem {
        let backButton = UIBarButtonItem(title: nil, style: .Plain, target: self.navigationController, action: #selector(UINavigationController.backButtonAction))
        backButton.setFAIcon(.FAAngleLeft, iconSize: 25.0)
        return backButton
    }
    
    private func clearCurrentLeftBarButtonItems() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.leftBarButtonItems = nil
        self.navigationItem.backBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
    
}

// MARK: Button action handling

extension UINavigationController {
    
    func backButtonAction() {
        popViewControllerAnimated(true)
    }
    
}
