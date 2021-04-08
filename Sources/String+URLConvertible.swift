//
//  String+URLConvertible.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 18/06/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import Foundation

extension String: URLConvertible {
    public func toUrl() throws -> URL {
        guard let url = URL(string: self) else { throw MNTError.invalidUrl(url: self) }

        return url
    }
}
