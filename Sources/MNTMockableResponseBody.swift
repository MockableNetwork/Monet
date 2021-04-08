//
//  MNTMockableResponseBody.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 07/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

protocol MNTMockableResponseBody {
    func toData() throws -> Data
}
