//
//  Errors.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 16/06/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import Foundation

public protocol Describable {
    var description: String { get }
}

public enum MNTError: Error {
    public enum InvalidResponseReason {
        case badRequest
        case unauthorized
        case forbidden
        case notFound
        case methodNotAllowed
        case requestTimeout
        case unprocessableEntity
        case tooManyRequests
        case internalServerError
        case serviceUnavailable
        case gatewayTimeout
        case other(error: Error)
    }

    public enum MockFailReason: Error {
        case invalidData
        case noMock
        case unreadableMockFile(file: String)
    }

    case invalidUrl(url: URLConvertible)
    case requestFail
    case invalidResponse(reason: InvalidResponseReason)
    case parseFail
    case mockFail(reason: MockFailReason)
    case other(error: Error)
}

extension MNTError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .invalidUrl(url):
            return "\(url) is not a valid URL."
        case let .invalidResponse(reason):
            return reason.description
        case .other(let error):
            return error.localizedDescription
        case .parseFail:
            return "Something went wrong while parsing data."
        case .requestFail:
            return "Request creation was not possible."
        case let .mockFail(reason):
            return reason.description
        }
    }

    public var localizedDescription: String {
        return errorDescription ?? "Unknown error."
    }
}

extension MNTError.MockFailReason: Describable {
    public var description: String {
        switch self {
        case .invalidData:
            return "Mock data is not valid."
        case .unreadableMockFile(let file):
            return "\(file) is unreadable or unreachable"
        case .noMock:
            return "Mock has not been specified."
        }
    }
}

extension MNTError.InvalidResponseReason: Describable {
    public var description: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .methodNotAllowed:
            return "Method Not Allowed"
        case .requestTimeout:
            return "Request Timeout"
        case .unprocessableEntity:
            return "Unprocessable Entity"
        case .tooManyRequests:
            return "Too Many Requests"
        case .internalServerError:
            return "Internal Server Error"
        case .serviceUnavailable:
            return "Service Unavailable"
        case .gatewayTimeout:
            return "Gateway Timeout"
        case let .other(error):
            return error.localizedDescription
        }
    }
}
