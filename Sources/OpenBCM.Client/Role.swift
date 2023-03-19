//
//  Role.swift
//  OpenBCM.Client
//  
//
//  Created by Andrew Satori on 2/16/23.
//

import Foundation
import RESTfulCore

/// Role is a Read Only implementation of the server side permissions
/// used primarily in the User Manager, however it can be.
public class Role : RESTfulResult, ObservableObject {
    internal static let path : String = "api/user/role"
    
    public var id: String?
    public var description: String?
    public var name: String?
    public var normalizedName: String?

    /// init()
    ///   Create an empty instance of the Role object
    ///
    /// - Parameters:
    /// - Returns:
    ///   - instance of a Role
    required public init() {
        super.init()
    }
    
    /// init()
    ///   Create an instance of the Role object that is populated by the
    ///   contents found within the passed in dictionary.
    ///
    ///   #NOTES#
    ///
    /// - Parameters:
    ///     with: Dictionary of String, Any that contains the initial values
    ///           for the object
    /// - Returns:
    ///   - instance of a User as defined by the Dictionary
    required public init(with: [String: Any]?) {
        super.init(with: with)
        if (with == nil) { return }
        
        id = with!["id"] as? String
        description = with!["description"] as? String
        name = with!["name"] as? String
        normalizedName = with!["normalizedName"] as? String
    }
    
    // MARK: Codable

    private enum CodingKeys: String, CodingKey {
        case id
        case description
        case name
        case normalizedName
    }
    
    // MARK: Decodable
    
    /// init()
    ///   Create an instance of the User object that is populated by the
    ///   contents found within the passed in decoder.
    ///
    ///   #NOTES#
    ///
    /// - Parameters:
    ///     from: Decoder that contains the initial values for the object
    /// - Returns:
    ///   - instance of a User as defined by the Dictionary
    public required init(from: Decoder) throws {
        try super.init(from: from)
        
        let values = try from.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decodeIfPresent(String?.self, forKey: .id)!
        self.description = try values.decodeIfPresent(String?.self, forKey: .description)!
        self.name = try values.decodeIfPresent(String?.self, forKey: .name)!
        self.normalizedName = try values.decodeIfPresent(String?.self, forKey: .normalizedName)!
    }
    
    // MARK: Encodable
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
        try container.encode(name, forKey: .name)
        try container.encode(normalizedName, forKey: .normalizedName)
        
    }
    
    // MARK: Equitable
    
    public static func == (lhs: Role, rhs: Role) -> Bool {
        if (lhs.id == rhs.id) { return false }
        if (lhs.description == rhs.description) { return false }
        if (lhs.name == rhs.name) { return false }
        if (lhs.normalizedName == rhs.normalizedName) { return false }
        
        return true;
    }
    
    // MARK: Hashable Protocol
    
    public override func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        
        hasher.combine(id)
        hasher.combine(description)
        hasher.combine(name)
        hasher.combine(normalizedName)
        
    }
}

// MARK: Connection Functions
/*
extension Role {
    // List
    // Query
    // Users
 
 
 
    public static func login(connection: Connection,
                             user: String,
                             password: String,
                             completion: @escaping (RESTfulResult?) -> Void
    ) {
        let login = Login()
        login.userName = user
        login.password = password
        
        connection.post(path: Login.path, model: login) {
            (results : Result<RESTfulResult?, Error> ) in
            switch results {
            case .failure( _):
                let res = RESTfulResult()
                res.succeeded = false
                res.info = connection.info
                completion(res)
            case .success(let result):
                completion(result)
            }
        }
    }
    
    public static func login(connection: Connection,
                             user: String,
                             password: String) async throws -> RESTfulResult? {
        let login = Login()
        login.userName = user
        login.password = password
        
        return try await connection.post(path: Login.path, model: login)
    }
    
    public static func logout(connection: Connection,
                              completion: @escaping (Bool) -> Void
    ) {
        connection.delete(path: Login.path, id: "") { (results : Result<RESTfulResult?, Error> ) in
            switch results {
            case .failure( _):
                completion(false)
            case .success( _):
                completion(true)
            }
        }
    }
    
    public static func logout(connection: Connection) async throws -> Bool {
        return try await connection.delete(path: Login.path, id: nil)
    }
}
*/
