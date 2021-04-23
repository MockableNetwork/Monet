//
//  MNTMockFileTests.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 13/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import XCTest
@testable import Monet

class MNTFileMockTests: XCTestCase {
    func testInit() {
        let mock = MNTFileMock(filename: "File", fileExtension: "json")

        XCTAssertEqual(mock.bundle, .main)
        XCTAssertEqual(mock.filename, "File")
        XCTAssertEqual(mock.fileExtension, "json")
        XCTAssertEqual(mock.fullName, "File.json")
        XCTAssertNil(mock.path)
    }

    func testPath() {
        let badMock = MNTFileMock(filename: "Mock",
                                  fileExtension: "json")
        let realMock = MNTFileMock(filename: "Mock",
                                   fileExtension: "json",
                                   bundle: Bundle(for: type(of: self)))

        XCTAssertNil(badMock.path)
        XCTAssertNotNil(realMock.path)
    }

    func testToDataFailure() {
        let mock = MNTFileMock(filename: "Mock",
                               fileExtension: "json")
        do {
            _ = try mock.toData()
            XCTFail("This mock should fail conversion")
        } catch MNTError.mockFail(reason: let reason) {
            XCTAssertEqual(reason.localizedDescription,
                           "Mock.json is not present in specified bundle.")
        } catch {
            XCTFail("Error should be handled above")
        }
    }

    func testToDataSuccess() {
        let mock = MNTFileMock(filename: "Mock",
                               fileExtension: "json",
                               bundle: Bundle(for: type(of: self)))

        do {
            let data = try mock.toData()
            XCTAssertNotNil(data)
        } catch {
            print("error")
            print(error.localizedDescription)
            XCTFail("Should succed")
        }
    }
}
