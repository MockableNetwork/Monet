//
//  MNTURLSessionDataTaskMockTests.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 16/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import XCTest
@testable import Monet

class MNTURLSessionDataTaskMockTests: XCTestCase {
    func testResume() {
        let dataTask = MNTURLSessionDataTaskMock()

        XCTAssertFalse(dataTask.called)

        dataTask.resume()
        XCTAssertTrue(dataTask.called)
    }
}
