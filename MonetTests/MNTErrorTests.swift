//
//  MNTErrorTests.swift
//  MonetTests iOS
//
//  Created by Francisco Javier Chacon de Dios on 08/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import XCTest
@testable import Monet

class MNTErrorTests: XCTestCase {
    func testInvalidUrlReason() {
        XCTAssertEqual(MNTError.invalidUrl(url: "www. fake .com").localizedDescription,
                       "www. fake .com is not a valid URL.")
    }

    func testInvalidResponseReason() {
        let genericError = NSError(domain: "io.monet.error",
                                   code: 500,
                                   userInfo: [NSLocalizedDescriptionKey: "Something failed"])
        XCTAssertEqual(MNTError.invalidResponse(reason: genericError).localizedDescription,
                       genericError.localizedDescription)

        let voidError = NSError(domain: "io.monet.error",
                                code: 500,
                                userInfo: [:])
        XCTAssertEqual(MNTError.invalidResponse(reason: voidError).localizedDescription,
                       voidError.localizedDescription)
    }

    func testParseFailReason() {
        XCTAssertEqual(MNTError.parseFail.localizedDescription,
                       "Something went wrong during parse process.")
    }

    func testRequestFailReason() {
        XCTAssertEqual(MNTError.requestFail.localizedDescription,
                       "Request creation failed.")
    }

    func testMockFailReasons() {
        XCTAssertEqual(MNTError.mockFail(reason: .invalidData).localizedDescription, "Mock data is not valid.")
        XCTAssertEqual(MNTError.mockFail(reason: .noMock).localizedDescription, "Mock has not been specified.")
        XCTAssertEqual(MNTError.mockFail(reason: .unreadableMockFile(file: "Test.json")).localizedDescription, "Test.json is unreadable or unreachable")
    }

    func testOtherReason() {
        let error = NSError(domain: "io.monet.error",
                            code: 500,
                            userInfo: [NSLocalizedDescriptionKey: "Other."])
        XCTAssertEqual(MNTError.other(error: error).localizedDescription,
                       error.localizedDescription)
    }
}
