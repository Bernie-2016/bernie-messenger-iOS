//
//  Reusable.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

protocol Reusable : class {

    static var reuseIdentifier: String { get }

}

extension Reusable {
    
    static var reuseIdentifier: String {
        return String(self) + "ReuseIdentifier"
    }
    
}

// MARK: UITableViewCell extension

extension UITableViewCell : Reusable {
    
}

// MARK: UITableViewHeaderFooterView extension

extension UITableViewHeaderFooterView : Reusable {
    
}
