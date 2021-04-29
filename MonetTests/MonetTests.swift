//
//  MonetTests.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 04/02/18.
//

import XCTest
import Monet

class MonetTests: XCTestCase {
    override func setUpWithError() throws {
        Monet.shared.clearMocks()
    }

    func testSharedInstanceURLSession() {
        let monet: Monet = .shared

        XCTAssert(monet.urlSession is MNTURLSessionMock)

        let mock = MNTMock(body: "{\"project\": \"Monet\"}",
                           error: nil,
                           status: .success,
                           urlConvertible: "www.test.com",
                           method: .get)
        let urlSession = monet.urlSession as! MNTURLSessionMock

        monet.setMock(mock)

        XCTAssertEqual(urlSession.mocks.count, 1)
        XCTAssertEqual(mock, urlSession.mocks.first!)
    }

    func testInit() {
        let configuration = MNTConfiguration(urlSession: MNTURLSession(),
                                             urlSessionMock: MNTURLSessionMock(),
                                             debugKey: "OTHER")
        let monet = Monet(configuration: configuration)

        XCTAssert(monet.urlSession is MNTURLSession)
    }

    func testFetchFromRequestWithMocks() {
        let successExpectation = expectation(description: "Success")
        let monet: Monet = .shared
        let bodyMock = MNTFileMock(filename: "Mock",
                                   fileExtension: "json",
                                   bundle: .init(for: type(of: self)))
        let mock = MNTMock(body: bodyMock,
                           error: nil,
                           status: .success,
                           urlConvertible: "www.test.com",
                           method: .get)
        monet.setMock(mock)

        var request = URLRequest(url: try! "www.test.com".toUrl())
        request.httpMethod = "GET"

        monet.fetch(fromRequest: request) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            successExpectation.fulfill()
        }

        wait(for: [successExpectation], timeout: 5)
    }

    func testFetchFromUrlWithMocks() {
        let successExpectation = expectation(description: "Success")
        let monet: Monet = .shared
        let bodyMock = MNTFileMock(filename: "Mock",
                                   fileExtension: "json",
                                   bundle: .init(for: type(of: self)))
        let mock = MNTMock(body: bodyMock,
                           error: nil,
                           status: .success,
                           urlConvertible: "www.test.com",
                           method: .get)
        monet.setMock(mock)

        monet.fetch(fromURL: "www.test.com",
                    method: .get,
                    headers: ["name": "Monet"]) { (data, response, error) in
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            successExpectation.fulfill()
        }

        wait(for: [successExpectation], timeout: 5)
    }

    func testFetchFromUrlWithBadUrl() {
        let successExpectation = expectation(description: "Failure")
        let monet: Monet = .shared
        let bodyMock = MNTFileMock(filename: "Mock",
                                   fileExtension: "json",
                                   bundle: .init(for: type(of: self)))
        let mock = MNTMock(body: bodyMock,
                           error: nil,
                           status: .success,
                           urlConvertible: "www.bad url.com",
                           method: .get)
        monet.setMock(mock)

        monet.fetch(fromURL: "www.bad url.com",
                    method: .get,
                    headers: ["name": "Monet"]) { (data, response, error) in
            XCTAssertNil(data)
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription,
                           MNTError.invalidUrl(url: "www.bad url.com").localizedDescription)
            successExpectation.fulfill()
        }

        wait(for: [successExpectation], timeout: 5)
    }

    func testFetchFromUrlWithNoMock() {
        let successExpectation = expectation(description: "Failure")
        let monet: Monet = .shared

        monet.fetch(fromURL: "www.test.com",
                    method: .get,
                    headers: ["name": "Monet"]) { (data, response, error) in
            XCTAssertNil(data)
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription,
                           MNTError.mockFail(reason: .noMock).localizedDescription)
            successExpectation.fulfill()
        }

        wait(for: [successExpectation], timeout: 5)
    }
}
