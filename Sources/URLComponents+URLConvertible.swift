//
//  URLComponent+URLConvertible.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 18/06/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import Foundation

extension URLComponents: URLConvertible {
    public func toUrl() throws -> URL {
        guard let url = url else {
            throw MNTError.invalidUrl(url: self)
        }

        return url
    }
}
