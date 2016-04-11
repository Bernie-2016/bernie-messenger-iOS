//
//  UITableView+Reusable.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

extension UITableView {
    
    // MARK: Cell reuse
    
    func registerReusableCell<T: UITableViewCell where T: Reusable>(_: T.Type) {
        registerClass(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerReusableCell<T: UITableViewCell where T: LoadableFromNib, T: Reusable>(_: T.Type) {
        registerNib(T.loadableFromNib(), forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell where T: Reusable>(indexPath: NSIndexPath) -> T {
        guard let cell = dequeueReusableCellWithIdentifier(T.reuseIdentifier, forIndexPath: indexPath) as? T else {
            // should never get here
            fatalError()
        }
        
        return cell
    }
    
    // MARK: Section header/footer reuse
    
    func registerReusableHeaderFooter<T: UITableViewHeaderFooterView where T: Reusable>(_: T.Type) {
        registerClass(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerReusableHeaderFooter<T: UITableViewHeaderFooterView where T: LoadableFromNib, T: Reusable>(_: T.Type) {
        registerNib(T.loadableFromNib(), forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView where T: Reusable>() -> T {
        guard let headerFooter = dequeueReusableHeaderFooterViewWithIdentifier(T.reuseIdentifier) as? T else {
            // should never get here
            fatalError()
        }
        
        return headerFooter
    }
    
}
