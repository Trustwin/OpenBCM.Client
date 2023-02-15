//
//  User.swift
//  OpenBCM.Client
//
//  Created by Andrew Satori on 2/15/23.
//

import Foundation
import RESTfulCore

// TODO: Rework this a little to support returning a User object instead of a
//       RESTfulResult.


public class User : RESTfulResult {
    internal static let path : String = "api/user/"
    
    public var firstName: String?
    public var lastName: String?
    public var registered: Date?
    public var sessionExpires: Date?
    public var id: String?
    public var userName: String?
    public var email: String?
    public var phoneNumber: String?
    public var emailConfirmed: Bool = false
    public var phoneNumberConfirmed: Bool = false
    public var twoFactorEnabled: Bool = false
    public var lockoutEnd: Date?
    public var lockoutEnabled: Bool = true
    public var accessFailedCount: Int?
    
    /// init()
    ///   Create an empty instance of the User object
    ///
    ///   #NOTES#
    ///
    /// - Parameters:
    /// - Returns:
    ///   - instance of a User
    required public init() {
        super.init()
    }
    
    /// init()
    ///   Create an instance of the User object that is populated by the
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
        
        firstName = with!["firstName"] as? String
        lastName = with!["lastName"] as? String
        registered = with!["registered"] as? Date
        sessionExpires = with!["sessionExpires"] as? Date
        id = with!["id"] as? String
        userName = with!["userName"] as? String
        email = with!["email"] as? String
        phoneNumber = with!["phoneNumber"] as? String
        emailConfirmed = with!["emailConfirmed"] as? Bool ?? false
        phoneNumberConfirmed = with!["phoneNumberConfirmed"] as? Bool ?? false
        twoFactorEnabled = with!["twoFactorEnabled"] as? Bool ?? true
        lockoutEnd = with!["lockoutEnd"] as? Date
        lockoutEnabled = with!["lockoutEnabled"] as? Bool ?? true
        accessFailedCount = with!["accessFailedCount"] as? Int
    }
    
    // MARK: Codable

    private enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case registered
        case sessionExpires
        case id
        case userName
        case email
        case phoneNumber
        case emailConfirmed
        case phoneNumberConfirmed
        case twoFactorEnabled
        case lockoutEnd
        case lockoutEnabled
        case accessFailedCount
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
        
        self.firstName = try values.decodeIfPresent(String?.self, forKey: .firstName)!
        self.lastName = try values.decodeIfPresent(String?.self, forKey: .lastName)!
        self.registered = try values.decodeIfPresent(Date?.self, forKey: .registered)!
        self.sessionExpires = try values.decodeIfPresent(Date?.self, forKey: .sessionExpires)!
        self.id = try values.decodeIfPresent(String?.self, forKey: .id)!
        self.userName = try values.decodeIfPresent(String?.self, forKey: .userName)!
        self.email = try values.decodeIfPresent(String?.self, forKey: .email)!
        self.phoneNumber = try values.decodeIfPresent(String?.self, forKey: .phoneNumber)!
        self.emailConfirmed = try values.decodeIfPresent(Bool.self, forKey: .emailConfirmed)!
        self.phoneNumberConfirmed = try values.decodeIfPresent(Bool.self, forKey: .phoneNumberConfirmed)!
        self.twoFactorEnabled = try values.decodeIfPresent(Bool.self, forKey: .twoFactorEnabled)!
        self.lockoutEnd = try values.decodeIfPresent(Date?.self, forKey: .lockoutEnd)!
        self.lockoutEnabled = try values.decodeIfPresent(Bool.self, forKey: .lockoutEnabled)!
        self.accessFailedCount = try values.decodeIfPresent(Int?.self, forKey: .accessFailedCount)!
    }
    
    // MARK: Encodable
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(registered, forKey: .registered)
        try container.encode(sessionExpires, forKey: .sessionExpires)
        try container.encode(id, forKey: .id)
        try container.encode(userName, forKey: .userName)
        try container.encode(email, forKey: .email)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(emailConfirmed, forKey: .emailConfirmed)
        try container.encode(phoneNumberConfirmed, forKey: .phoneNumberConfirmed)
        try container.encode(twoFactorEnabled, forKey: .twoFactorEnabled)
        try container.encode(lockoutEnd, forKey: .lockoutEnd)
        try container.encode(lockoutEnabled, forKey: .lockoutEnabled)
        try container.encode(accessFailedCount, forKey: .accessFailedCount)
        
    }
    
    // MARK: Equitable
    
    public static func == (lhs: User, rhs: User) -> Bool {
        if (lhs.firstName == rhs.firstName) { return false }
        if (lhs.lastName == rhs.lastName) { return false }
        if (lhs.registered == rhs.registered) { return false }
        if (lhs.sessionExpires == rhs.sessionExpires) { return false }
        if (lhs.id == rhs.id) { return false }
        if (lhs.userName == rhs.userName) { return false }
        if (lhs.email == rhs.email) { return false }
        if (lhs.phoneNumber == rhs.phoneNumber) { return false }
        if (lhs.emailConfirmed == rhs.emailConfirmed) { return false }
        if (lhs.phoneNumberConfirmed == rhs.phoneNumberConfirmed) { return false }
        if (lhs.twoFactorEnabled == rhs.twoFactorEnabled) { return false }
        if (lhs.lockoutEnd == rhs.lockoutEnd) { return false }
        if (lhs.lockoutEnabled == rhs.lockoutEnabled) { return false }
        if (lhs.accessFailedCount == rhs.accessFailedCount) { return false }
        
        return true;
    }
    
    // MARK: Hashable Protocol
    
    public override func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        
        hasher.combine(firstName)
        hasher.combine(lastName)
        hasher.combine(registered)
        hasher.combine(sessionExpires)
        hasher.combine(id)
        hasher.combine(userName)
        hasher.combine(email)
        hasher.combine(phoneNumber)
        hasher.combine(emailConfirmed)
        hasher.combine(phoneNumberConfirmed)
        hasher.combine(twoFactorEnabled)
        hasher.combine(lockoutEnd)
        hasher.combine(lockoutEnabled)
        hasher.combine(accessFailedCount)
        
    }
}

// MARK: Connection Functions
/*
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
*/
