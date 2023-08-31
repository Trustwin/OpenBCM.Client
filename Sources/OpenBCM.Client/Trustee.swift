//
//  Trustee.swift
//  
//
//  Created by Andrew Satori on 8/30/23.
//

import Foundation
import RESTfulCore

// TODO: Rework this a little to support returning a User object instead of a
//       RESTfulResult.


public class Trustee : RESTfulResult, ObservableObject {
    internal static let path : String = "api/trustee/"
    
    public var id: String = ""
    public var name: String = ""
    public var division: String = ""
    public var court: String = ""
    public var chapter: Int8 = 13
    
    /// init()
    ///   Create an empty instance of the Trustee object
    ///
    ///   #NOTES#
    ///
    /// - Parameters:
    /// - Returns:
    ///   - instance of a Trustee
    required public init() {
        super.init()
    }
    
    /// init()
    ///   Create an instance of the Trustee object that is populated by the
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
        
        id = with!["id"] as? String ?? ""
        name = with!["name"] as? String ?? ""
        division = with!["divisoin"] as? String ?? ""
        court = with!["court"] as? String ?? ""
        chapter = with!["chapter"] as? Int8 ?? 13
    }
    
    // MARK: Codable

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case division
        case court
        case chapter
    }
    
    // MARK: Decodable
    
    /// init()
    ///   Create an instance of the Trustee object that is populated by the
    ///   contents found within the passed in decoder.
    ///
    ///   #NOTES#
    ///
    /// - Parameters:
    ///     from: Decoder that contains the initial values for the object
    /// - Returns:
    ///   - instance of a Trustee as defined by the Dictionary
    public required init(from: Decoder) throws {
        try super.init(from: from)
        
        let values = try from.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decodeIfPresent(String.self, forKey: .id)!
        self.name = try values.decodeIfPresent(String.self, forKey: .name)!
        self.division = try values.decodeIfPresent(String.self, forKey: .division)!
        self.court = try values.decodeIfPresent(String.self, forKey: .court)!
        self.chapter = try values.decodeIfPresent(Int8.self, forKey: .chapter)!
    }
    
    // MARK: Encodable
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(division, forKey: .division)
        try container.encode(court, forKey: .court)
        try container.encode(chapter, forKey: .chapter)

    }
    
    // MARK: Equitable
    
    public static func == (lhs: Trustee, rhs: Trustee) -> Bool {
        if (lhs.id == rhs.id) { return false }
        if (lhs.name == rhs.name) { return false }
        if (lhs.division == rhs.division) { return false }
        if (lhs.court == rhs.court) { return false }
        if (lhs.chapter == rhs.chapter) { return false }
        
        return true;
    }
    
    // MARK: Hashable Protocol
    
    public override func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(division)
        hasher.combine(court)
        hasher.combine(chapter)
    }
}

// MARK: Connection Functions

extension Trustee {
    public static func current(connection: Connection,
                             completion: @escaping (Trustee?) -> Void
    ) {
        connection.get(path: Trustee.path) {
            (results : Result<Trustee?, Error> ) in
            switch results {
            case .failure( _):
                let res = Trustee()
                res.succeeded = false
                res.info = connection.info
                completion(res)
            case .success(let result):
                completion(result)
            }
        }
    }
    
    public static func current(connection: Connection) async throws -> Trustee? {
        return try await connection.get(path: Trustee.path)
    }
}
