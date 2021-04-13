//
//  MNTHTTPURLResponseMock.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 07/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

class MNTHTTPURLResponseMock {
    var url: URLConvertible
    var statusCode: Int
    var headers: Headers

    init(url: URLConvertible, statusCode: Int, headers: Headers = [:]) {
        self.url = url
        self.statusCode = statusCode
        self.headers = headers
    }

    convenience init(url: URLConvertible, status: RequestStatus, headers: Headers = [:]) {
        self.init(url: url, statusCode: status.code, headers: headers)
    }

    func httpResponse() throws -> HTTPURLResponse? {
        return HTTPURLResponse(url: try url.toUrl(),
                               statusCode: statusCode,
                               httpVersion: "HTTP/1.1",
                               headerFields: headers)
    }

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
