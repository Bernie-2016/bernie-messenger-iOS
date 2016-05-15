//
//  TableViewCell.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/14/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import PureLayout
import UIKit

class TableViewCell : UITableViewCell {
    
    private lazy var customBackgroundView: TableViewCellBackgroundView = TableViewCellBackgroundView(frame: self.bounds)
    
    var disabled: Bool = false {
        didSet {
            self.userInteractionEnabled = !self.disabled
            self.contentView.alpha = self.disabled ? 0.2 : 1.0
        }
    }
    
    var customSeparatorInset: UIEdgeInsets {
        set {
            self.customBackgroundView.separatorInset = newValue
        }
        get {
            return self.customBackgroundView.separatorInset
        }
    }
    
    // MARK: Inits
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundView = self.customBackgroundView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundView = self.customBackgroundView
    }
    
}

// MARK: Private background view class

private class TableViewCellBackgroundView : UIView {
    
    lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(hex: 0xE0E0E0)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.autoSetDimension(.Height, toSize: 1.0)
        return separator
    }()
    
    var separatorLeadingConstraint: NSLayoutConstraint!
    var separatorTrailingConstraint: NSLayoutConstraint!
    
    var separatorInset: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 0.0) {
        didSet {
            self.separatorLeadingConstraint.constant = self.separatorInset.left
            self.separatorTrailingConstraint.constant = self.separatorInset.right
        }
    }
    
    // MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSeparatorLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpSeparatorLine()
    }
    
    func setUpSeparatorLine() {
        addSubview(self.separator)
        self.separatorLeadingConstraint = self.separator.autoPinEdgeToSuperviewEdge(.Leading, withInset: 15.0)
        self.separatorTrailingConstraint = self.separator.autoPinEdgeToSuperviewEdge(.Trailing)
        self.separator.autoPinEdgeToSuperviewEdge(.Bottom)
    }
    
}
