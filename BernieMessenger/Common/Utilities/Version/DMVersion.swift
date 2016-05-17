//
//  Version.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

struct Version : Comparable {
    
    let majorVersion: UInt
    let minorVersion: UInt
    let patchVersion: UInt
    
}

extension Version {
    
    init(stringVersion: String) {
        let versionComponents = stringVersion.componentsSeparatedByString(".")
        let transform: (versionComponents: [String], atIndex: Int) -> UInt = {
            (components: [String], index: Int) in
            
            // Check if the components array has the desired index
            guard components.indices.contains(index) else {
                return 0
            }
            return UInt(components[index]) ?? 0
        }
        
        self.majorVersion = transform(versionComponents: versionComponents, atIndex: 0)
        self.minorVersion = transform(versionComponents: versionComponents, atIndex: 1)
        self.patchVersion = transform(versionComponents: versionComponents, atIndex: 2)
    }
    
}

// MARK: Comparable

func ==(lhs: Version, rhs: Version) -> Bool {
    return lhs.majorVersion == rhs.majorVersion &&
        lhs.minorVersion == rhs.minorVersion &&
        lhs.patchVersion == rhs.patchVersion
}

func <(lhs: Version, rhs: Version) -> Bool {
    if lhs.majorVersion != rhs.majorVersion {
        return lhs.majorVersion < rhs.majorVersion
    } else if lhs.minorVersion != rhs.minorVersion {
        return lhs.minorVersion < rhs.minorVersion
    } else {
        return lhs.patchVersion < rhs.patchVersion
    }
}
