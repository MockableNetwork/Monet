//
//  URLConvertible.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 17/06/20.
//  Copyright © 2020 Monet. All rights reserved.
//

import Foundation

public protocol URLConvertible {
    func toUrl() throws -> URL
}
