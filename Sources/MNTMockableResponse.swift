//
//  MNTMockableResponse.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 07/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

class MNTMockableResponse {
    var url: URLConvertible
    var statusCode: Int
    var headers: Headers

    init(url: URLConvertible, statusCode: Int, headers: Headers) {
        self.url = url
        self.statusCode = statusCode
        self.headers = headers
    }

    func httpResponse() throws -> HTTPURLResponse? {
        return HTTPURLResponse(url: try url.toUrl(),
                               statusCode: statusCode,
                               httpVersion: "1.1",
                               headerFields: headers)
    }
}
