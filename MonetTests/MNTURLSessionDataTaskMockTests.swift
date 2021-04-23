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
    func testResumeWithNoMockError() {
        let dataTaskExpectation = expectation(description: "Data Task Response")
        let dataTask = MNTURLSessionDataTaskMock(mock: nil) { (_, _, error) in
            XCTAssertEqual(error?.localizedDescription,
                           MNTError.mockFail(reason: .noMock).localizedDescription)
            dataTaskExpectation.fulfill()
        }

        XCTAssertFalse(dataTask.called)

        dataTask.resume()
        XCTAssertTrue(dataTask.called)

        wait(for: [dataTaskExpectation], timeout: 2)
    }

    func testResumeWithWrongURLError() {
        let dataTaskExpectation = expectation(description: "Data Task Response")
        let mock = MNTMock(body: MNTJSONStringMock("{\"project\": \"Monet\"}"),
                           error: nil,
                           status: .success,
                           urlConvertible: "www.bad url.com",
                           method: .get)

        let dataTask = MNTURLSessionDataTaskMock(mock: mock) { (_, _, error) in
            XCTAssertEqual(error?.localizedDescription,
                           MNTError.invalidUrl(url: "www.bad url.com").localizedDescription)
            dataTaskExpectation.fulfill()
        }

        XCTAssertFalse(dataTask.called)

        dataTask.resume()
        XCTAssertTrue(dataTask.called)

        wait(for: [dataTaskExpectation], timeout: 2)
    }

    func testResumeWithWrongMockNotPresentInBundle() {
        let dataTaskExpectation = expectation(description: "Data Task Response")
        let mock = MNTMock(body: MNTFileMock(filename: "File",
                                             fileExtension: "json",
                                             bundle: .init(for: type(of: self))),
                           error: nil,
                           status: .success,
                           urlConvertible: "www.test.com",
                           method: .get)
        let dataTask = MNTURLSessionDataTaskMock(mock: mock) { (_, _, error) in
            XCTAssertEqual(error?.localizedDescription,
                           MNTError.mockFail(reason: .notPresentInBundle(file: "File.json")).localizedDescription)
            dataTaskExpectation.fulfill()
        }

        XCTAssertFalse(dataTask.called)

        dataTask.resume()
        XCTAssertTrue(dataTask.called)

        wait(for: [dataTaskExpectation], timeout: 2)
    }

    func testResumeWithSuccessFileMock() {
        let dataTaskExpectation = expectation(description: "Data Task Response")
        let mock = MNTMock(body: MNTFileMock(filename: "Mock",
                                             fileExtension: "json",
                                             bundle: .init(for: type(of: self))),
                           error: nil,
                           status: .success,
                           urlConvertible: "www.test.com",
                           method: .get)
        let dataTask = MNTURLSessionDataTaskMock(mock: mock) { (data, response, error) in
            XCTAssertNotNil(data)
            XCTAssertEqual(String(data: data ?? Data(), encoding: .utf8),
                           "{\n    \"project\": \"Monet\"\n}\n")
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.url, try? "www.test.com".toUrl())
            XCTAssertNil(error)
            dataTaskExpectation.fulfill()
        }

        XCTAssertFalse(dataTask.called)

        dataTask.resume()
        XCTAssertTrue(dataTask.called)

        wait(for: [dataTaskExpectation], timeout: 2)
    }

    func testResumeWithSuccessJSONStringMock() {
        let dataTaskExpectation = expectation(description: "Data Task Response")
        let mock = MNTMock(body: MNTJSONStringMock("{\"project\": \"Monet\"}"),
                           error: nil,
                           status: .success,
                           urlConvertible: "www.test.com",
                           method: .get)
        let dataTask = MNTURLSessionDataTaskMock(mock: mock) { (data, response, error) in
            XCTAssertNotNil(data)
            XCTAssertEqual(String(data: data ?? Data(), encoding: .utf8),
                           "{\"project\": \"Monet\"}")
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.url, try? "www.test.com".toUrl())
            XCTAssertNil(error)
            dataTaskExpectation.fulfill()
        }

        XCTAssertFalse(dataTask.called)

        dataTask.resume()
        XCTAssertTrue(dataTask.called)

        wait(for: [dataTaskExpectation], timeout: 2)
    }
}
