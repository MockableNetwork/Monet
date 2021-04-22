//
//  MNTURLSessionMock.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 19/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

class MNTURLSessionMock: MNTMockableURLSession {
    var mocks: [MNTMock] = []

    func setMock(_ mock: MNTMock) {
        if mocks.contains(mock) {
            let index = mocks.firstIndex(of: mock)!
            mocks[index] = mock
        }
        mocks.append(mock)
    }

    func dataTask(request: URLRequest, _ completionHandler: @escaping DataTaskResult) -> MNTMockableDataTask {
        if let url = request.url {
            return MNTURLSessionDataTaskMock(mock: mocks.first(where: { url.toString() == $0.urlConvertible.toString() }),
                                             completionHandler: completionHandler)

        }
        return MNTURLSessionDataTaskMock(mock: nil,
                                         completionHandler: completionHandler)
    }
}
