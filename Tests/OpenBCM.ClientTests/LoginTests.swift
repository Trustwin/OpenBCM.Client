//
//  APILoginTests.swift
//
//
//  Created by Andrew Satori on 1/19/22.
//

import XCTest
import RESTfulCore

@testable import OpenBCM_Client

// TODO: Consolidate the Register and Login Tests into a single linear test
//       to ensure that the system works as designed.

class LoginTests: XCTestCase {
    private var config : TestConfiguration = TestConfiguration()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginLogout() throws {
        XCTAssertNotNil(config.host, "No Host Setup:\n\tdefaults write openbcm.client.tests host \"http://localhost\"")
        XCTAssertNotNil(config.user, "No User Setup:\n\tdefaults write openbcm.client.tests user \"testUser\"")
        XCTAssertNotNil(config.pass, "No Password Setup:\n\tdefaults write openbcm.client.tests pass \"testPassword\"")

        let expectation = XCTestExpectation(description: "testLoginValidate")
        let connection : Connection = Connection(basePath: config.host!)
        Login.login(connection: connection, user: config.user!, password: config.pass!) {
            (result) in
            if (result == nil) {
                XCTAssertTrue(result == nil, "No Result Returned")
                expectation.fulfill()
            }
            XCTAssertTrue(result!.succeeded,
                          "Unable to validate login")
            
            // got here, trigger the logout
            Login.logout(connection: connection) { (result : Bool) in
                XCTAssertTrue(result == true, "Lougout Failed")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoginLogoutAsync() async throws {
        XCTAssertNotNil(config.host, "No Host Setup:\n\tdefaults write openbcm.client.tests host \"http://localhost\"")
        XCTAssertNotNil(config.user, "No User Setup:\n\tdefaults write openbcm.client.tests user \"testUser\"")
        XCTAssertNotNil(config.pass, "No Password Setup:\n\tdefaults write openbcm.client.tests pass \"testPassword\"")

        let connection : Connection = Connection(basePath: config.host!)
        let loggedIn : RESTfulResult? = try await Login.login(connection: connection,
                                          user: config.user!,
                                          password: config.pass!)
        XCTAssertTrue(loggedIn != nil, "No Result Returned")
        XCTAssertTrue(loggedIn!.succeeded, "Unable to validate login")
            
        // got here, trigger the logout
        let loggedOut : Bool = try await Login.logout(connection: connection)
        XCTAssertTrue(loggedOut == true, "Lougout Failed")
    }

}
