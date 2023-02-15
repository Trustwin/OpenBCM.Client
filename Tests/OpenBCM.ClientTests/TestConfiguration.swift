//
//  TestConfiguration.swift
//  OpenBCM.Client.Tests
//
//  Created by Andrew Satori on 6/8/22.
//

// to set via command line
//  defaults write openbcm.client.tests host "http://localhost"

import Foundation

class TestConfiguration {
    public var host : String?
    public var user : String?
    public var pass : String?

    public init() {
        if let userDefaults = UserDefaults(suiteName: "openbcm.client.tests") {
            host = userDefaults.string(forKey: "host")
            user = userDefaults.string(forKey: "user")
            pass = userDefaults.string(forKey: "pass")
        }
    }
    
    public func write() {
        if let userDefaults = UserDefaults(suiteName: "openbcm.client.tests") {
            userDefaults.set(host as AnyObject, forKey: "host")
            userDefaults.set(user as AnyObject, forKey: "user")
            userDefaults.set(pass as AnyObject, forKey: "pass")
            userDefaults.synchronize()
        }
         
    }
    
    
}
