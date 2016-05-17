//
//  UITableView+Utils.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

extension UITableView {
    
    func update(actions actions: (() -> Void)? = nil) {
        beginUpdates()
        actions?()
        endUpdates()
    }
    
}
