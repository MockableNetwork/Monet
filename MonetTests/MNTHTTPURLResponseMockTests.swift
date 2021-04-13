//
//  MNTHTTPURLResponseMockTests.swift
//  MonetTests iOS
//
//  Created by Francisco Javier Chacon de Dios on 09/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import XCTest
@testable import Monet

class MNTHTTPURLResponseMockTests: XCTestCase {
    func testInitStatusCode() {
        let response = MNTHTTPURLResponseMock(url: "www.google.com",
                                              statusCode: 404,
                                              headers: [:])
        let httpResponse = HTTPURLResponse(url: try! "www.google.com".toUrl(),
                                           statusCode: 404,
                                           httpVersion: "HTTP/1.1",
                                           headerFields: [:])

        let mockResponse = try! response.httpResponse()
        XCTAssertNotNil(mockResponse)
        XCTAssertEqual(httpResponse?.statusCode, mockResponse?.statusCode)
        XCTAssertEqual(httpResponse?.url, mockResponse?.url)
        XCTAssertEqual(httpResponse?.allHeaderFields.count, mockResponse?.allHeaderFields.count)

        do {
            _ = try MNTHTTPURLResponseMock.init(url: "bad url", status: .notFound).httpResponse()
            XCTFail("An error should have been catched")
        } catch {
            XCTAssertEqual(error.localizedDescription, "bad url is not a valid URL.")
        }
    }

    func testInitStatus() {
        let response = MNTHTTPURLResponseMock(url: "www.google.com",
                                              status: .notFound)
        let httpResponse = HTTPURLResponse(url: try! "www.google.com".toUrl(),
                                           statusCode: 404,
                                           httpVersion: "HTTP/1.1",
                                           headerFields: [:])
        let mockResponse = try! response.httpResponse()
        XCTAssertNotNil(mockResponse)
        XCTAssertEqual(httpResponse?.statusCode, mockResponse?.statusCode)
        XCTAssertEqual(httpResponse?.url, mockResponse?.url)
        XCTAssertEqual(httpResponse?.allHeaderFields.count, mockResponse?.allHeaderFields.count)
    }

    func testRequestStatus() {
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.success.code, 200)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.created.code, 201)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.accepted.code, 202)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.noContent.code, 204)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.multipleChoice.code, 300)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.movedPermanently.code, 301)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.found.code, 302)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.temporaryRedirect.code, 307)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.permanentRedirect.code, 308)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.badRequest.code, 400)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.unauthorised.code, 401)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.forbidden.code, 403)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.notFound.code, 404)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.requestTimedOut.code, 408)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.unprocessableEntity.code, 422)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.internalServerError.code, 500)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.notImplemented.code, 501)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.serviceTemporaryOverloaded.code, 502)
        XCTAssertEqual(MNTHTTPURLResponseMock.RequestStatus.serviceUnavailable.code, 503)
    }
}
