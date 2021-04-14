//
//  String+MNTMockableResponseBody.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 07/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

extension String: MNTBodyMock {
    func toData() throws -> Data {
        if let data = data(using: .utf8) {
            return data
        }
        throw MNTError.MockFailReason.invalidData
    }
}
