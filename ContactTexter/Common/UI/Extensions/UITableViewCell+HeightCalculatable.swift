//
//  UITableViewCell+HeightCalculatable.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    /**
     Calculates the height of a `UITableViewCell`.
     
     Unfortunately, iOS8 is extremely buggy and require the cell's `UITableView` to properly 
     calculate the height. Ideally, when iOS9 is the minimum version, this can be changed to 
     a calculated property as the parameter will no longer be needed.
     
     - parameter tableView: The `UITableView` that will display the cell.
     
     - returns: The height of the `UITableViewCell`.
     */
    func calculatedHeight(tableView tableView: UITableView) -> CGFloat {
        if systemVersionIsGreaterThanOrEquals("9") {
            return UITableViewAutomaticDimension
        }
        
        // On iOS 8, size classes are not properly evaluated after dequeueing because they have no superview
        // and, therefore, its size classes are unspecified. This can be resolved by temporarily adding the
        // cell to its table view so it takes on the table view's size class traits.
        let needsTemporarySuperview = self.superview == nil
        if needsTemporarySuperview {
            tableView.addSubview(self)
        }
        
        // Account for an offset for the accessory view
        let widthOffset: CGFloat
        if let accessoryView = self.accessoryView {
            // iOS provides a non-configurable 16pt(iPhone)/20pt(iPad) of margin to accessory views
            let accessoryViewMargin: CGFloat = UIDevice.currentDevice().isTablet ? 20.0 : 16.0
            widthOffset = accessoryView.frame.width + accessoryViewMargin
        } else {
            widthOffset = 0.0
        }
        
        // Makes sure view's width is equal to tableView's width (can be wrong since they are in separated nibs)
        self.bounds = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: self.bounds.height)
        self.contentView.bounds = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width - widthOffset, height: self.bounds.height)
        
        // The content needs to be layed out to calculate the height properly
        layoutIfNeeded()
        
        let height = ceil(self.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height)
        
        // Remove from table view, if necessary
        if needsTemporarySuperview {
            removeFromSuperview()
        }
        
        return height
    }
    
}
