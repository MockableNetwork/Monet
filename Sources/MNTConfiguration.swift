//
//  MNTConfiguration.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 20/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

class MNTConfiguration {
    static let `default`: MNTConfiguration = .init(urlSession: MNTURLSession(),
                                                   urlSessionMock: MNTURLSessionMock())
    var urlSession: MNTMockableURLSession
    var urlSessionMock: MNTMockableURLSession
    var debugKey: String

    init(urlSession: MNTMockableURLSession,
         urlSessionMock: MNTMockableURLSession,
         debugKey: String = "DEBUG") {
        self.urlSession = urlSession
        self.urlSessionMock = urlSessionMock
        self.debugKey = debugKey
    }
}
