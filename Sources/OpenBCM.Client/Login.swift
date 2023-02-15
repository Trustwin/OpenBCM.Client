//
//  Login.swift
//  OpenBCM.Client
//
//  Created by Andrew Satori on 1/31/23.
//

import Foundation
import RESTfulCore

public class Login : RESTObject {
    internal static let path : String = "api/user/login/"

    public var loginId: Int?
    public var userName : String = ""
    public var password : String = ""
    public var uid  : String = ""
    
    /// init()
    ///
    ///   #NOTES#
    ///
    /// - Parameters:
    /// - Returns:
    ///   - instance of a Login
    required public init() {
        super.init()
    }
      
    required public init(with: [String: Any]?) {
        super.init(with: with)
        if (with == nil) { return }
        
        loginId = with!["loginId"] as? Int
    }
    
    // MARK: Codable

    private enum CodingKeys: String, CodingKey {
        case loginId
        case userName
        case password
        case uid
    }
    
    // MARK: Decodable
    
    public required init(from: Decoder) throws {
        try super.init(from: from)
        
        let values = try from.container(keyedBy: CodingKeys.self)
        
        self.loginId = try values.decodeIfPresent(Int.self, forKey: .loginId)!
        self.userName = try values.decodeIfPresent(String.self, forKey: .userName)!
        self.password = try values.decodeIfPresent(String.self, forKey: .password)!
        self.uid = try values.decodeIfPresent(String.self, forKey: .uid)!
    }
    
    // MARK: Encodable
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(loginId, forKey: .loginId)
        try container.encode(userName, forKey: .userName)
        try container.encode(password, forKey: .password)
        try container.encode(uid, forKey: .uid)
    }
    
    // MARK: Equitable
    
    public static func == (lhs: Login, rhs: Login) -> Bool {
        if (lhs.loginId == rhs.loginId) { return false }
        if (lhs.userName == rhs.userName) { return false }
        if (lhs.password == rhs.password) { return false }
        if (lhs.uid == rhs.uid) { return false }

        return true;
    }
    
    // MARK: Hashable Protocol
    
    public override func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        
        hasher.combine(loginId)
        hasher.combine(userName)
        hasher.combine(password)
        hasher.combine(uid)
    }
}

// MARK: Connection Functions

extension Login {
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
