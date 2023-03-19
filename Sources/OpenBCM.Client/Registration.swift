//
//  UserRegistration.swift
//  OpenBCM.Client
//
//
//  Created by Andrew Satori on 1/15/23.
//

import Foundation
import RESTfulCore

public class Registration : RESTObject, ObservableObject {
    internal static let path : String = "api/User/Register/"

    public var firstName : String? = nil
    public var lastName : String? = nil
    public var password : String? = nil
    public var confirmPassword : String? = nil
    public var email : String? = nil
      
    required public init() {
        super.init()
    }
    
    required public init(with: [String: Any]?) {
        super.init(with: with)
        if (with == nil) { return }
        
        firstName = with!["firstName"] as? String
        lastName = with!["lastName"] as? String
        password = with!["password"] as? String
        confirmPassword = with!["confirmPassword"] as? String
        email = with!["email"] as? String
    }
    
    // MARK: Codable

    private enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case password
        case confirmPassword
        case email
    }
    
    // MARK: Decodable
    
    public required init(from: Decoder) throws {
        try super.init(from: from)
        
        let values = try from.container(keyedBy: CodingKeys.self)
              
        self.firstName = try values.decodeIfPresent(String.self, forKey: .firstName)!
        self.lastName = try values.decodeIfPresent(String.self, forKey: .lastName)!
        self.password = try values.decodeIfPresent(String.self, forKey: .password)!
        self.confirmPassword = try values.decodeIfPresent(String.self, forKey: .confirmPassword)!
        self.email = try values.decodeIfPresent(String.self, forKey: .email)!
    }
    
    // MARK: Encodable
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
    
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(password, forKey: .password)
        try container.encode(confirmPassword, forKey: .confirmPassword)
        try container.encode(email, forKey: .email)
    }
    
    // MARK: Equitable
    
    public static func == (lhs: Registration, rhs: Registration) -> Bool {
        if (lhs.firstName == rhs.firstName) { return false }
        if (lhs.lastName == rhs.lastName) { return false }
        if (lhs.password == rhs.password) { return false }
        if (lhs.confirmPassword == rhs.confirmPassword) { return false }
        if (lhs.email == rhs.email) { return false }

        return true;
    }
    
    // MARK: Hashable Protocol
    
    public override func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        
        hasher.combine(firstName)
        hasher.combine(lastName)
        hasher.combine(password)
        hasher.combine(confirmPassword)
        hasher.combine(email)
    }
}

// MARK: Connection Functions

extension Registration {
    
    public func register(connection: Connection) async throws -> RESTfulResult? {
        // internally, this is a post of a user object to the 'registration' api
        let result : RESTfulResult? = try await connection.post(
            path: Registration.path, model: self)
        return result
    }
    
    public static func confirm(connection: Connection, email: String, token: String) async throws -> RESTfulResult? {
        let path : String = "\(Registration.path)"
        let query : String = "email=\(email)&token=\(token)"
        let result : RESTfulResult? = try await connection.get(path: path, query: query)
        return result
    }
}

 
