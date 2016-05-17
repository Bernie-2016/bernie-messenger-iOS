//
//  LoadableFromNib.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

protocol LoadableFromNib : class {
    
    static var loadableFromNibName: String { get }
    static func loadableFromNib(bundle: NSBundle) -> UINib

}

extension LoadableFromNib {
    
    static var loadableFromNibName: String {
        return String(self)
    }
    
    static func loadableFromNib(bundle: NSBundle = NSBundle.mainBundle()) -> UINib {
        return UINib(nibName: loadableFromNibName, bundle: bundle)
    }
    
}

extension LoadableFromNib where Self : UIView {
    
    static func loadFromNib() -> Self {
        let bundle = NSBundle.mainBundle()
        let view = bundle.loadNibNamed(loadableFromNibName, owner: nil, options: nil).first
        
        return view as! Self
    }
    
}

extension LoadableFromNib where Self : UIViewController {
    
    static func loadFromNib(bundle: NSBundle = NSBundle.mainBundle()) -> Self {
        return Self(nibName: loadableFromNibName, bundle: bundle)
    }
    
}
