//
//  File.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 15/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol MNTMockableURLSession {
    func setMock(_ mock: MNTMock, forUrl url: URLConvertible)
    func dataTask(request: URLRequest,
                  _ completionHandler: @escaping DataTaskResult) -> MNTMockableDataTask
}
