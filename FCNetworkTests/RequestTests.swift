//
//  RequestTests.swift
//  FCNetwork
//
//  Created by Francisco Javier Chacon de Dios on 05/02/18.
//

import XCTest
import FCNetwork

class RequestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testHTTPMethodGet() {
        let httpMethod: HTTPMethod = .get
        XCTAssertEqual("GET", httpMethod.getMethodString())
    }

    func testHTTPMethodPatch() {
        let httpMethod: HTTPMethod = .patch
        XCTAssertEqual("PATCH", httpMethod.getMethodString())
    }

    func testHTTPMethodPut() {
        let httpMethod: HTTPMethod = .put
        XCTAssertEqual("PUT", httpMethod.getMethodString())
    }

    func testHTTPMethodPost() {
        let httpMethod: HTTPMethod = .post
        XCTAssertEqual("POST", httpMethod.getMethodString())
    }

    func testHTTPMethodDelete() {
        let httpMethod: HTTPMethod = .delete
        XCTAssertEqual("DELETE", httpMethod.getMethodString())
    }
}
