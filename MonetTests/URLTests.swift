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
        let url = URL(string: "www.example.com")!

        XCTAssertEqual(url, try! url.toUrl())
    }

    func testString() {
        let url = URL(string: "www.example.com")!

        XCTAssertEqual(url.toString(), "www.example.com")
    }
}
