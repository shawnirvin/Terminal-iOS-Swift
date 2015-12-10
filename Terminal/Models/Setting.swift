//
//  Setting.swift
//  Terminal
//
//  Created by Shawn Irvin on 12/9/15.
//  Copyright © 2015 Shawn Irvin. All rights reserved.
//

import UIKit

enum SettingType: String {
    case ShowTime = "time"
    
    func defaultValue() -> AnyObject {
        let path = NSBundle.mainBundle().pathForResource("Defaults", ofType: "plist")!
        let defaults = NSDictionary(contentsOfFile: path)!
        return defaults.objectForKey(self.rawValue)!
    }
}

class Setting: NSObject {
    private static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    static func setDefaultForSettingType(value: AnyObject, type: SettingType?) {
        if let validType = type {
            userDefaults.setObject(value, forKey: validType.rawValue)
        }
    }
    
    static func defaultForSettingType(type: SettingType?) -> AnyObject? {
        if let validType = type {
            return userDefaults.objectForKey(validType.rawValue)
        }
        
        return nil
    }
    
    static func restoreDefaults() {
        for key in userDefaults.dictionaryRepresentation().keys {
            if let settingType = SettingType(rawValue: key) {
                userDefaults.setObject(settingType.defaultValue(), forKey: key)
            }
        }
    }
    
    static func setDefaultsIfNotSet() {
        //Check if defaults have already been set
        for key in userDefaults.dictionaryRepresentation().keys {
            if let _ = SettingType(rawValue: key) {
                return
            }
        }
        
        //If not, retrieve and set them
        let path = NSBundle.mainBundle().pathForResource("Defaults", ofType: "plist")!
        let defaults = NSDictionary(contentsOfFile: path)!
        
        for key in defaults.allKeys {
            userDefaults.setObject(defaults.objectForKey(key), forKey: key as! String)
        }
    }
}
