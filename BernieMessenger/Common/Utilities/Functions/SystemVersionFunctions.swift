//
//  SystemVersionFunctions.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import UIKit

func systemVersionEquals(stringVersion: String) -> Bool {
    return UIDevice.currentDevice().iOSVersion == Version(stringVersion: stringVersion)
}

func systemVersionIsGreaterThan(stringVersion: String) -> Bool {
    return UIDevice.currentDevice().iOSVersion > Version(stringVersion: stringVersion)
}

func systemVersionIsGreaterThanOrEquals(stringVersion: String) -> Bool {
    return UIDevice.currentDevice().iOSVersion >= Version(stringVersion: stringVersion)
}

func systemVersionIsLessThan(stringVersion: String) -> Bool {
    return UIDevice.currentDevice().iOSVersion < Version(stringVersion: stringVersion)
}

func systemVersionIsLessThanOrEquals(stringVersion: String) -> Bool {
    return UIDevice.currentDevice().iOSVersion <= Version(stringVersion: stringVersion)
}
