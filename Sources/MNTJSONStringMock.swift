//
//  MNTJSONStringMock.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 14/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

class MNTJSONStringMock: MNTBodyMock {
    private var value: String

    init(_ value: String) {
        self.value = value
    }

    func toData() throws -> Data {
        return try value.toData()
    }
}
