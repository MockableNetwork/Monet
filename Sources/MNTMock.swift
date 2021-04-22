//
//  MNTMock.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 19/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

struct MNTMock: Equatable {
    var body: MNTBodyMock
    var error: Error?
    var statusCode: Int
    var urlConvertible: URLConvertible
    var method: HTTPMethod
    var headers: Headers

    init(body: MNTBodyMock, error: Error?, statusCode: Int, urlConvertible: URLConvertible, method: HTTPMethod, headers: Headers = [:]) {
        self.body = body
        self.error = error
        self.statusCode = statusCode
        self.urlConvertible = urlConvertible
        self.method = method
        self.headers = headers
    }

    init(body: MNTBodyMock, error: Error?, status: RequestStatus, urlConvertible: URLConvertible, method: HTTPMethod, headers: Headers = [:]) {
        self.body = body
        self.error = error
        self.statusCode = status.code
        self.urlConvertible = urlConvertible
        self.method = method
        self.headers = headers
    }

    func httpResponse() throws -> HTTPURLResponse?{
        return HTTPURLResponse(url: try urlConvertible.toUrl(),
                               statusCode: statusCode,
                               httpVersion: "HTTP/1.1",
                               headerFields: headers)
    }

    static func == (lhs: MNTMock, rhs: MNTMock) -> Bool {
        lhs.method == rhs.method &&
            lhs.urlConvertible.toString() == rhs.urlConvertible.toString()
    }
}

extension MNTMock {
    enum RequestStatus {
        case success
        case created
        case accepted
        case noContent
        case multipleChoice
        case movedPermanently
        case found
        case temporaryRedirect
        case permanentRedirect
        case badRequest
        case unauthorised
        case forbidden
        case notFound
        case requestTimedOut
        case unprocessableEntity
        case internalServerError
        case notImplemented
        case serviceTemporaryOverloaded
        case serviceUnavailable

        var code: Int {
            switch self {
            case .success:
                return 200
            case .created:
                return 201
            case .accepted:
                return 202
            case .noContent:
                return 204
            case .multipleChoice:
                return 300
            case .movedPermanently:
                return 301
            case .found:
                return 302
            case .temporaryRedirect:
                return 307
            case .permanentRedirect:
                return 308
            case .badRequest:
                return 400
            case .unauthorised:
                return 401
            case .forbidden:
                return 403
            case .notFound:
                return 404
            case .requestTimedOut:
                return 408
            case .unprocessableEntity:
                return 422
            case .internalServerError:
                return 500
            case .notImplemented:
                return 501
            case .serviceTemporaryOverloaded:
                return 502
            case .serviceUnavailable:
                return 503
            }
        }
    }
}
