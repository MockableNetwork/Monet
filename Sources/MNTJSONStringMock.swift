//
//  MNTJSONStringMock.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 14/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

public class MNTJSONStringMock: MNTBodyMock {
    private var value: String

    public init(_ value: String) {
        self.value = value
    }

    public func toData() throws -> Data {
        return try value.toData()
    }
}
