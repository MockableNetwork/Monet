//
//  MNTMockTests.swift
//  MonetTests iOS
//
//  Created by Francisco Javier Chacon de Dios on 09/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import XCTest
@testable import Monet

class MNTMockTests: XCTestCase {
    func testInitStatus() {
        let mock = MNTMock(body: "",
                           error: nil,
                           status: .success,
                           urlConvertible: "www.test.com",
                           method: .get)
        XCTAssertEqual(mock.method, .get)
        XCTAssertEqual(mock.statusCode, 200)
        XCTAssertEqual(mock.urlConvertible.toString(), "www.test.com")
    }

    func testInitStatusCode() {
        let mock = MNTMock(body: "",
                           error: nil,
                           statusCode: 300,
                           urlConvertible: "www.test.com",
                           method: .get)
        XCTAssertEqual(mock.method, .get)
        XCTAssertEqual(mock.statusCode, 300)
        XCTAssertEqual(mock.urlConvertible.toString(), "www.test.com")
    }

    func testHTTPResponse() {
        let mock = MNTMock(body: "",
                           error: nil,
                           statusCode: 300,
                           urlConvertible: "www.test.com",
                           method: .get)
        do {
            let response = try mock.httpResponse()
            XCTAssertEqual(response?.url?.toString(), "www.test.com")
        } catch {
            XCTFail()
        }
    }

    func testHTTPResponseFail() {
        let mock = MNTMock(body: "",
                           error: nil,
                           statusCode: 300,
                           urlConvertible: "www.bad url.com",
                           method: .get)
        do {
            _ = try mock.httpResponse()
            XCTFail()
        } catch {
            XCTAssertEqual(error.localizedDescription,
                           MNTError.invalidUrl(url: "www.bad url.com").localizedDescription)
        }
    }

    func testRequestStatus() {
        XCTAssertEqual(MNTMock.RequestStatus.success.code, 200)
        XCTAssertEqual(MNTMock.RequestStatus.created.code, 201)
        XCTAssertEqual(MNTMock.RequestStatus.accepted.code, 202)
        XCTAssertEqual(MNTMock.RequestStatus.noContent.code, 204)
        XCTAssertEqual(MNTMock.RequestStatus.multipleChoice.code, 300)
        XCTAssertEqual(MNTMock.RequestStatus.movedPermanently.code, 301)
        XCTAssertEqual(MNTMock.RequestStatus.found.code, 302)
        XCTAssertEqual(MNTMock.RequestStatus.temporaryRedirect.code, 307)
        XCTAssertEqual(MNTMock.RequestStatus.permanentRedirect.code, 308)
        XCTAssertEqual(MNTMock.RequestStatus.badRequest.code, 400)
        XCTAssertEqual(MNTMock.RequestStatus.unauthorised.code, 401)
        XCTAssertEqual(MNTMock.RequestStatus.forbidden.code, 403)
        XCTAssertEqual(MNTMock.RequestStatus.notFound.code, 404)
        XCTAssertEqual(MNTMock.RequestStatus.requestTimedOut.code, 408)
        XCTAssertEqual(MNTMock.RequestStatus.unprocessableEntity.code, 422)
        XCTAssertEqual(MNTMock.RequestStatus.internalServerError.code, 500)
        XCTAssertEqual(MNTMock.RequestStatus.notImplemented.code, 501)
        XCTAssertEqual(MNTMock.RequestStatus.serviceTemporaryOverloaded.code, 502)
        XCTAssertEqual(MNTMock.RequestStatus.serviceUnavailable.code, 503)
    }
}
