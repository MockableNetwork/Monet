//
//  MNTURLSessionDataTask.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 16/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

class MNTURLSessionDataTaskMock: MNTMockableDataTask {
    var called: Bool = false

    func resume() {
        called = true
    }
}
