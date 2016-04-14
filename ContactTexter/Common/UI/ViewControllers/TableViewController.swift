//
//  TableViewController.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class TableViewController : UITableViewController, ViewControllerType {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLeftBarButtonItem()
        setUpNavigiationItemTitle()
        setUpRightBarButtonItem()
        
        if #available(iOS 9, *) {
            self.tableView.cellLayoutMarginsFollowReadableWidth = false
        }
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
