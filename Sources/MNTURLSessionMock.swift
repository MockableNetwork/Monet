//
//  MNTURLSessionMock.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 19/04/21.
//  Copyright © 2021 Monet. All rights reserved.
//

import Foundation

class MNTURLSessionMock: MNTMockableURLSession {
    var mocks: [URL: MNTMock] = [:]

    func setMock(_ mock: MNTMock, forUrl url: URLConvertible) {
        do {
            let transformedUrl = try url.toUrl()
            mocks.updateValue(mock, forKey: transformedUrl)
        } catch {
            print(error.localizedDescription)
        }
    }

    func dataTask(request: URLRequest, _ completionHandler: @escaping DataTaskResult) -> MNTMockableDataTask {
        completionHandler(Data(),
                          URLResponse(url: try! "".toUrl(),
                                      mimeType: "",
                                      expectedContentLength: 1,
                                      textEncodingName: ""),
                          nil)

        if let url = request.url {
            return MNTURLSessionDataTaskMock(mock: mocks[url],
                                             completionHandler: completionHandler)

        }
        return MNTURLSessionDataTaskMock(mock: nil,
                                         completionHandler: completionHandler)
    }
}
