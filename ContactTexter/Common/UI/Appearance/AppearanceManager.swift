//
//  AppearanceManager.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class AppearanceManager {
    
    static func configureDefaultAppearances() {
        configureNavigationBarAppearance()
    }
    
    private static func configureNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().barTintColor = UIColor.primaryBlue()
        UINavigationBar.appearance().barStyle = .Black
    }
    
}
