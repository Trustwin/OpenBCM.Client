//
//  TrusteeTests.swift
//  
//
//  Created by Andrew Satori on 8/30/23.
//

import XCTest
import RESTfulCore

@testable import OpenBCM_Client

final class TrusteeTests: XCTestCase {
    private let testName : String = "TrusteeTests"
    private var config : TestConfiguration = TestConfiguration()


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCurrent() throws {
        XCTAssertNotNil(config.host, "No Host Setup:\n\tdefaults write openbcm.client.tests host \"http://localhost\"")
        XCTAssertNotNil(config.user, "No User Setup:\n\tdefaults write openbcm.client.tests user \"testUser\"")
        XCTAssertNotNil(config.pass, "No Password Setup:\n\tdefaults write openbcm.client.tests pass \"testPassword\"")
        let expectation = XCTestExpectation(description: "\(testName): get()")
        let connection : Connection = Connection(basePath: config.host!)

        // Test implementation

        Trustee.current(connection: connection) {
            (result) in
            if (result == nil) {
                XCTAssertTrue(result == nil, "No Result Returned")
                expectation.fulfill()
            }
            XCTAssertTrue(result!.succeeded,
                          "Request Failed: \(result!.info ?? [""])")
            XCTAssertTrue(result!.id == "MBOK", "Data Mismatch")
            
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCurrentAsync() async throws {
        XCTAssertNotNil(config.host, "No Host Setup:\n\tdefaults write openbcm.client.tests host \"http://localhost\"")
        XCTAssertNotNil(config.user, "No User Setup:\n\tdefaults write openbcm.client.tests user \"testUser\"")
        XCTAssertNotNil(config.pass, "No Password Setup:\n\tdefaults write openbcm.client.tests pass \"testPassword\"")
        let expectation = XCTestExpectation(description: "\(testName): get()")
        let connection : Connection = Connection(basePath: config.host!)

        let result : Trustee? = try await Trustee.current(connection: connection);
        XCTAssertTrue(result!.succeeded,
                      "Request Failed: \(result!.info ?? [""])")
        XCTAssertTrue(result!.id == "MBOK", "Data Mismatch")
       
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
