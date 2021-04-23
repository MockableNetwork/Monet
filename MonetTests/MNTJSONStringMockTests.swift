//
//  MNTJSONStringMockTests.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 15/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import XCTest
@testable import Monet

class MNTJSONStringMockTests: XCTestCase {
    func testToData() {
        let string = "{ \"project\": \"Monet\" }"
        let mock = MNTJSONStringMock(string)

        do {
            let data = try mock.toData()
            XCTAssertEqual(String(data: data, encoding: .utf8)!, string)
        } catch {
            XCTFail()
        }
    }
}
