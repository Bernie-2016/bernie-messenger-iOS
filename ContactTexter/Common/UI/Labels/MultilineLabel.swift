//
//  MultilineLabel.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

class MultilineLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.numberOfLines = 0
    }
    
    override var bounds: CGRect {
        didSet {
            updatePreferredMaxLayoutWidthIfNecessary()
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        updatePreferredMaxLayoutWidthIfNecessary()
        return super.intrinsicContentSize()
    }
    
    // MARK: Private helper methods
    
    private func updatePreferredMaxLayoutWidthIfNecessary() {
        if systemVersionIsLessThan("9") && self.preferredMaxLayoutWidth != self.bounds.width {
            self.preferredMaxLayoutWidth = self.bounds.width
            setNeedsUpdateConstraints()
        }
    }
    
}
