//
//  FCNetworkTests_iOS.swift
//  FCNetworkTests iOS
//
//  Created by Francisco Javier Chacon de Dios on 04/02/18.
//

import XCTest
import FCNetwork

class FCNetworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }


    func testGetString() {
        XCTAssertEqual(get(), "get")
    }
}
