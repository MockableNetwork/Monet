//
//  MNTURLSessionDataTask.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 16/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

public class MNTURLSessionDataTaskMock: MNTMockableDataTask {
    public var called: Bool = false
    public var mock: MNTMock?
    public var completionHandler: DataTaskResult

    public init(mock: MNTMock?, completionHandler: @escaping DataTaskResult) {
        self.mock = mock
        self.completionHandler = completionHandler
    }

    public func resume() {
        called = true
        guard let mock = mock else {
            return completionHandler(nil,
                                     nil,
                                     MNTError.mockFail(reason: .noMock))
        }

        do {
            let data = try mock.body.toData()
            let response = try mock.httpResponse()
            completionHandler(data, response, mock.error)
        } catch {
            completionHandler(nil, nil, error)
        }
    }
}
