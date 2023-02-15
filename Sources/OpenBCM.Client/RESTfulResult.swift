//
//  RESTfulResult.swift
//  OpenBCM.Client
//
//  Created by Andrew Satori on 1/31/23.
//

import Foundation
import RESTfulCore

public class RESTfulResult : RESTObject {
    public var succeeded : Bool = false
    public var info : [String]?
    
    public required init() {
        // an empty init for put/post methods to use
        super.init()
    }
        
    required public init(with: [String: Any]?) {
        super.init(with: with)
        
        succeeded = with!["succeeded"] as? Bool ?? true
        info = with!["info"] as? [String]
        if (info == nil) {
            // try to parse the odd .net format elements
            let i = with!["info"] as? Dictionary<String, Any>
            if (i != nil) {
                info = i!["$values"] as? [String]
            }
        }
    }
     
    // MARK: Codable
    
    private enum CodingKeys: String, CodingKey {
        case succeeded
        case info
    }
    
    // MARK: Decodable
    
    public required init(from: Decoder) throws {
        try super.init(from: from)
        
        let values = try from.container(keyedBy: CodingKeys.self)
        
        self.succeeded = try values.decodeIfPresent(Bool.self, forKey: .succeeded)!
        self.info = try values.decodeIfPresent([String].self, forKey: .info)!
    }
    
    // MARK: Encodable
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(succeeded, forKey: .succeeded)
        try container.encode(succeeded, forKey: .succeeded)
    }
    
    // MARK: Equitable
    
    public static func == (lhs: RESTfulResult, rhs: RESTfulResult) -> Bool {
        if (lhs.succeeded == rhs.succeeded) { return false }
        if (lhs.succeeded == rhs.succeeded) { return false }

        return true;
    }
    
    // MARK: Hashable Protocol
    
    public override func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        hasher.combine(succeeded)
        hasher.combine(succeeded)
    }
}

