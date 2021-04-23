//
//  File.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 15/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

public typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

public protocol MNTMockableURLSession: NSObject {
    func setMock(_ mock: MNTMock)
    func clearMocks()
    func dataTask(request: URLRequest,
                  _ completionHandler: @escaping DataTaskResult) -> MNTMockableDataTask
}
