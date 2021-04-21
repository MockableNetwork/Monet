//
//  MNTURLSession.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 16/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

class MNTURLSession: MNTMockableURLSession {
    func setMock(_ mock: MNTMock, forUrl url: URLConvertible) {}

    func dataTask(request: URLRequest,
                  _ completionHandler: @escaping DataTaskResult) -> MNTMockableDataTask {
        return URLSession.shared.dataTask(with: request,
                                          completionHandler: completionHandler)
    }
}