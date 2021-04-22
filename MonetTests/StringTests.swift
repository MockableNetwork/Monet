//
//  StringTests.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 18/06/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import XCTest
@testable import Monet

class StringTests: XCTestCase {
    func testToUrl() {
        do {
            XCTAssertNotNil(try "www.example.com".toUrl())
            _ = try "www.bad url.com".toUrl()
        } catch {
            XCTAssertEqual(error.localizedDescription,
                           "www.bad url.com is not a valid URL.")
        }
    }

    func testString() {
        XCTAssertEqual("hello".toString(), "hello")
    }

    func testToData() {
        XCTAssertEqual(try "hello".toData(), "hello".data(using: .utf8)!)
    }
}
