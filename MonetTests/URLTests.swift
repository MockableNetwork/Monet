//
//  URLTests.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 18/06/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import XCTest

class URLTests: XCTestCase {
    func testToUrl() {
        guard let url = URL(string: "www.example.com") else {
            XCTFail("Example url is wrong")
            return
        }

        XCTAssertEqual(url, try? url.toUrl())
    }
}
