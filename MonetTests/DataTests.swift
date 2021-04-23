//
//  DataTests.swift
//  MonetTests iOS
//
//  Created by Francisco Javier Chacon de Dios on 09/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import XCTest
@testable import Monet

class DataTests: XCTestCase {
    func testToData() {
        XCTAssertEqual(try Data().toData(), Data())
    }
}
