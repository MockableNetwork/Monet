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
    public enum MockFailReason: Error {
        case invalidData
        case noMock
        case unreadableMockFile(file: String)
    }

    case invalidUrl(url: URLConvertible)
    case requestFail
    case invalidResponse(reason: Error)
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
            return reason.localizedDescription
        case .parseFail:
            return "Something went wrong during parse process."
        case .requestFail:
            return "Request creation failed."
        case let .mockFail(reason):
            return reason.description
        case .other(let error):
            return error.localizedDescription
        }
    }

    public var localizedDescription: String { errorDescription! }
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
