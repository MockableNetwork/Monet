//
//  MNTConfigurationTests.swift
//  MonetTests iOS
//
//  Created by Francisco Javier Chacon de Dios on 21/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import XCTest
@testable import Monet

class MNTConfigurationTests: XCTestCase {
    func testDefault() {
        let configuration: MNTConfiguration = .default

        XCTAssertEqual(configuration.debugKey, "DEBUG")
        XCTAssert(configuration.urlSession is MNTURLSession)
        XCTAssert(configuration.urlSessionMock is MNTURLSessionMock)
    }

    func testInit() {
        let configuration: MNTConfiguration = .init(urlSession: MNTURLSessionMock(),
                                                    urlSessionMock: MNTURLSession(),
                                                    debugKey: "TEST")

        XCTAssertEqual(configuration.debugKey, "TEST")
        XCTAssert(configuration.urlSession is MNTURLSessionMock)
        XCTAssert(configuration.urlSessionMock is MNTURLSession)
    }
}
