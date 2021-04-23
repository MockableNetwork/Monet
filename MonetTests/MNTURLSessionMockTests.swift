//
//  MNTURLSessionMockTests.swift
//  MonetTests iOS
//
//  Created by Francisco Javier Chacon de Dios on 21/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import XCTest
@testable import Monet

class MNTURLSessionMockTests: XCTestCase {
    func testSetMock() {
        let urlSession = MNTURLSessionMock()

        let firstMock = MNTMock(body: MNTJSONStringMock("{\"project\": \"Monet\"}"),
                           error: nil,
                           status: .success,
                           urlConvertible: "www.test.com",
                           method: .get)
        let secondMock = MNTMock(body: MNTJSONStringMock("{\"name\": \"Monet\"}"),
                                 error: nil,
                                 status: .success,
                                 urlConvertible: "www.test.com",
                                 method: .get)
        let thirdMock = MNTMock(body: MNTJSONStringMock("{\"name\": \"Monet\"}"),
                                error: nil,
                                status: .success,
                                urlConvertible: "www.test.com",
                                method: .post)

        urlSession.setMock(firstMock)

        XCTAssertEqual(urlSession.mocks.count, 1)
        XCTAssert(urlSession.mocks.contains(firstMock))
        XCTAssert(urlSession.mocks.contains(secondMock))
        XCTAssertEqual(String(data: try! urlSession.mocks.first!.body.toData(), encoding: .utf8),
                       "{\"project\": \"Monet\"}")

        urlSession.setMock(secondMock)
        XCTAssertEqual(urlSession.mocks.count, 1)
        XCTAssertEqual(String(data: try! urlSession.mocks.first!.body.toData(), encoding: .utf8),
                       "{\"name\": \"Monet\"}")

        urlSession.setMock(thirdMock)
        XCTAssertEqual(urlSession.mocks.count, 2)
    }

    func testDataTask() {
        let successExpectation = expectation(description: "Success call")
        let errorExpectation = expectation(description: "Error on call")

        let urlSession = MNTURLSessionMock()
        let mock = MNTMock(body: MNTJSONStringMock("{\"project\": \"Monet\"}"),
                           error: nil,
                           status: .success,
                           urlConvertible: "www.test.com",
                           method: .get)

        urlSession.setMock(mock)
        var request = URLRequest(url: try! "www.test.com".toUrl())
        request.httpMethod = "GET"
        urlSession.dataTask(request: request) { (data, response, error) in
            XCTAssertNotNil(data)
            XCTAssertEqual(String(data: data!, encoding: .utf8),
                           "{\"project\": \"Monet\"}")
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            successExpectation.fulfill()
        }.resume()

        var secondRequest = URLRequest(url: try! "www.test.com".toUrl())
        secondRequest.httpMethod = "POST"
        urlSession.dataTask(request: secondRequest) { (data, response, error) in
            XCTAssertNil(data)
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription,
                           MNTError.mockFail(reason: .noMock).localizedDescription)
            errorExpectation.fulfill()
        }.resume()

        wait(for: [successExpectation, errorExpectation], timeout: 3)
    }
}
