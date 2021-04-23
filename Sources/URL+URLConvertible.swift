//
//  URL+URLConvertible.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 18/06/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import Foundation

extension URL: URLConvertible {
    public func toString() -> String { absoluteString }

    public func toUrl() throws -> URL {
        return self
    }
}
