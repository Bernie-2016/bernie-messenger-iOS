//
//  UIColor+Utils.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

extension UIColor {
    
    /**
     Initializes and returns a color object using the specified hex value and alpha.
     
     - parameter hex: Hex value of the color.
     
     - returns: The `UIColor` object.
     */
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let components = (
            red: CGFloat((hex >> 16) & 0xff) / 255,
            green: CGFloat((hex >> 08) & 0xff) / 255,
            blue: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: alpha)
    }
    
    static func body() -> UIColor {
        return UIColor(hex: 0x364350)
    }
    
    static func primaryBlue() -> UIColor {
        return UIColor(hex: 0x0076D7)
    }
    
    static func primaryRed() -> UIColor {
        return UIColor(hex: 0xF55B5B)
    }
    
}
