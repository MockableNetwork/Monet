//
//  Monet.swift
//  Monet
//
//  Created by Francisco Javier Chacon de Dios on 04/02/18.
//

import Foundation

public typealias Headers = [String: String]
public typealias Parameters = [String: Any]

public class Monet {
    public static let shared: Monet = {
        return Monet(configuration: .default)
    }()
    private var configuration: MNTConfiguration
    public var urlSession: MNTMockableURLSession {
        if ProcessInfo().arguments.contains(configuration.debugKey) {
            return configuration.urlSessionMock
        }
        return configuration.urlSession
    }

    public init(configuration: MNTConfiguration) {
        self.configuration = configuration
    }

    public func setMock(_ mock: MNTMock) { urlSession.setMock(mock) }

    public func clearMocks() { urlSession.clearMocks() }

    public func fetch(fromRequest urlRequest: URLRequest,
                      handler: @escaping DataTaskResult) {
        urlSession.dataTask(request: urlRequest, handler).resume()
    }

    public func fetch(fromURL urlConvertible: URLConvertible,
                      method: HTTPMethod = .get,
                      headers: Headers? = nil,
                      handler: @escaping DataTaskResult) {

        do {
            let url = try urlConvertible.toUrl()
            var urlRequest: URLRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.getValue()

            if let headers = headers {
                for (key, value) in headers {
                    urlRequest.setValue(value, forHTTPHeaderField: key)
                }
            }

            urlSession.dataTask(request: urlRequest, handler).resume()
        } catch {
            handler(nil, nil, error)
        }
    }
}
