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
    var mock: MNTMock?
    var completionHandler: DataTaskResult

    init(mock: MNTMock?, completionHandler: @escaping DataTaskResult) {
        self.mock = mock
        self.completionHandler = completionHandler
    }

    func resume() {
        called = true
        guard let mock = mock else {
            return completionHandler(nil,
                                     nil,
                                     MNTError.mockFail(reason: .noMock))
        }

        do {
            let data = try mock.body.toData()
            let response = try mock.urlResponse.httpResponse()
            completionHandler(data, response, mock.error)
        } catch {
            completionHandler(nil, nil, error)
        }
    }
}
