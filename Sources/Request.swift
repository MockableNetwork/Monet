//
//  Request.swift
//  FCNetwork
//
//  Created by Francisco Javier Chacon de Dios on 04/02/18.
//

import Foundation

public enum HTTPMethod {
    case get, put, patch, post, delete

    public func getMethodString() -> String {
        switch self {
        case .get:
            return "GET"
        case .put:
            return "PUT"
        case .patch:
            return "PATCH"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}
