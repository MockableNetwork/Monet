//
//  String+MNTMockableResponseBody.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 07/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

extension String: MNTBodyMock {
    public func toData() throws -> Data {
        data(using: .utf8)!
    }
}
