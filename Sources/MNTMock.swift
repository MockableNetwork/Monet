//
//  MNTMock.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 19/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

public struct MNTMock: Equatable {
    public var body: MNTBodyMock
    public var error: Error?
    public var statusCode: Int
    public var urlConvertible: URLConvertible
    public var method: HTTPMethod
    public var headers: Headers

    public init(body: MNTBodyMock, error: Error?, statusCode: Int, urlConvertible: URLConvertible, method: HTTPMethod, headers: Headers = [:]) {
        self.body = body
        self.error = error
        self.statusCode = statusCode
        self.urlConvertible = urlConvertible
        self.method = method
        self.headers = headers
    }

    public init(body: MNTBodyMock, error: Error?, status: RequestStatus, urlConvertible: URLConvertible, method: HTTPMethod, headers: Headers = [:]) {
        self.body = body
        self.error = error
        self.statusCode = status.code
        self.urlConvertible = urlConvertible
        self.method = method
        self.headers = headers
    }

    public func httpResponse() throws -> HTTPURLResponse?{
        return HTTPURLResponse(url: try urlConvertible.toUrl(),
                               statusCode: statusCode,
                               httpVersion: "HTTP/1.1",
                               headerFields: headers)
    }

    public static func == (lhs: MNTMock, rhs: MNTMock) -> Bool {
        lhs.method == rhs.method &&
            lhs.urlConvertible.toString() == rhs.urlConvertible.toString()
    }
}

extension MNTMock {
    public enum RequestStatus {
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

        public var code: Int {
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
