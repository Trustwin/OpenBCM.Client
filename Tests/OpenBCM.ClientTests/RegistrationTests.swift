//
//  RegistrationTests.swift
//
//
//  Created by Andrew Satori on 1/15/23.
//

import XCTest
import RESTfulCore
@testable import OpenBCM_Client

final class RegistrationTests: XCTestCase {
    private var config : TestConfiguration = TestConfiguration()

     override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRegister() async throws {
        XCTAssertNotNil(config.host, "No Host Setup:\n\tdefaults write openbcm.client.tests host \"http://localhost\"")
        
        let connection : Connection = Connection(basePath: config.host!)
        
        let reg : Registration = Registration()
        reg.email = config.user!
        reg.password = config.pass!
        reg.confirmPassword = config.pass!
        reg.lastName = "Test"
        reg.firstName = "Unit"
        
        let result: RESTfulResult? = try await reg.register(connection: connection)
        if (result == nil) {
            XCTFail("There is no Result object returned from the request: \(connection.info?.joined(separator: "\n") ?? "")")
            return
        }
        XCTAssertTrue(result!.succeeded, "The request failed: \(result!.info?.joined(separator: "\n") ??  "")")
        
        // assuming the server is running in DEBUG mode, it will return the
        // token in the body, in addition to the email ( in production it is
        // just a user visible string )
        
        let token : String = result!.info![0]
        
        let confirmation : RESTfulResult? = try await Registration.confirm(connection: connection, email: reg.email ?? "", token: token);
        if (confirmation == nil) {
            XCTFail("There is no Result object returned from the confirmation: \(connection.info?.joined(separator: "\n") ?? "")")
            return
        }
        XCTAssertTrue(confirmation!.succeeded, "The confirmation failed: \(confirmation!.info?.joined(separator: "\n") ??  "")")
    }

}
