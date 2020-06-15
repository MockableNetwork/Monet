//
//  MonetTests_iOS.swift
//  MonetTests iOS
//
//  Created by Francisco Javier Chacon de Dios on 04/02/18.
//

import XCTest
import Monet

class MonetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }


    func testGetString() {
        XCTAssertEqual(get(), "get")
    }
}
