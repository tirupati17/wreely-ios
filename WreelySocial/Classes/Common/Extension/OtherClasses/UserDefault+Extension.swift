//
//  UserDefault+Extension.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 11/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    class func setStandardValue(_ value: Any?, forKey key : String) {
        let defaults = UserDefaults.standard
        defaults.setValue(value, forKey:key)
        defaults.synchronize()
    }
    
    class func getStandardValue(_ key: String) -> Any? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: key)
    }
}

extension DefaultsKeys {
    static let deviceToken = DefaultsKey<String?>("deviceToken")
    static let username = DefaultsKey<String?>("username")
    static let password = DefaultsKey<String?>("password")
    static let launchCount = DefaultsKey<Int>("launchCount")
    static let accessToken = DefaultsKey<String?>("accessToken")
    static let vendorLogo = DefaultsKey<String?>("vendorLogo")
    static let currentUser = DefaultsKey<Any?>("currentUser")
    
}
