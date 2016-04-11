//
//  UIDevice+Utils.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

extension UIDevice {
    
    var isHandset: Bool {
        return self.userInterfaceIdiom == .Phone
    }
    
    var isTablet: Bool {
        return self.userInterfaceIdiom == .Pad
    }
    
    var iOSVersion: Version {
        return Version(stringVersion: self.systemVersion)
    }
    
}
