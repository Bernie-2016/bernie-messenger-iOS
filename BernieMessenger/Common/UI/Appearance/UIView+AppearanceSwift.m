//
//  UIView+AppearanceSwift.m
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/13/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

#import "UIView+AppearanceSwift.h"

@implementation UIView (AppearanceSwift)

+ (instancetype)swift_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self appearanceWhenContainedIn:containerClass, nil];
}

@end
