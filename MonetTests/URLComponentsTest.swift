//
//  URLComponentsTest.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 18/06/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import XCTest

class URLComponentsTest: XCTestCase {
    func testToUrl() {
        do {
            let components = URLComponents(string: "www.example.com")
            XCTAssertNotNil(try components?.toUrl())

            let badComponents = URLComponents(string: "www.example.com")

            guard var extractedBadComponents = badComponents else {
                XCTFail("badComponents should not be nil")
                return
            }

            extractedBadComponents.host = "bad host"
            _ = try extractedBadComponents.toUrl()
        } catch {
            XCTAssertEqual("host: bad host path: www.example.com  is not a valid URL.", error.localizedDescription)
        }
    }

    func testToString() {
        var components = URLComponents(string: "www.example.com")
        components?.queryItems = [URLQueryItem(name: "test_name", value: "components")]

        XCTAssertEqual(components?.toString(),
                       "www.example.com?test_name=components")
        XCTAssertNil(URLComponents(string: "bad url")?.toString())
    }
}
