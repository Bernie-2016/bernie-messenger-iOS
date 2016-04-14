//
//  ViewController.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class ViewController : UIViewController, ViewControllerType {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLeftBarButtonItem()
        setUpNavigiationItemTitle()
        setUpRightBarButtonItem()
    }
    
    // MARK: ViewControllerType
    
    var titleType: NavigationItemTitleType {
        return .BernieLogo
    }
    
    var leftBarButtonItemType: LeftBarButtonItemType {
        return .None
    }
    
    var rightBarButtonItemType: RightBarButtonItemType {
        return .None
    }
    
}
