//
//  UIView+AppearanceSwift.h
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/13/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AppearanceSwift)

+ (instancetype)swift_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;

@end
