//
//  Request.swift
//  FCNetwork
//
//  Created by Francisco Javier Chacon de Dios on 04/02/18.
//

import Foundation

public enum HTTPMethod {
    case get, put, patch, post, delete

    public func getValue() -> String {
        switch self {
        case .get:
            return "GET"
        case .put:
            return "PUT"
        case .patch:
            return "PATCH"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}

public typealias Headers = [String: String]

public typealias Parameters = [String: Any]

public typealias ResponseResult = [String: Any]

public protocol URLString {
    func toURL() -> URL?
}

extension String: URLString {

    public func toURL() -> URL? {
        if let url = URL(string: self) {
            return url
        } else {
            return nil
        }
    }

}

open class NetworkRequest {

    open static let shared: NetworkRequest = { return NetworkRequest() }()

    func request(from urlString: URLString,
                 using method: HTTPMethod = .get,
                 sending headers: Headers? = nil,
                 and parameters: Parameters? = nil,
                 setting timeout: TimeInterval = 30,
                 success: @escaping(Data, URLResponse) -> Void,
                 fail: @escaping(Error) -> Void) {

        if let url = urlString.toURL() {
            var urlRequest: URLRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: timeout)

            if let headers = headers {
                for (key, value) in headers {
                    urlRequest.setValue(value, forHTTPHeaderField: key)
                }
            }

            URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if let data = data, let response = response {
                    success(data, response)
                } else if let error = error {
                    fail(error)
                }
            }).resume()
        } else {
            fail(NSError(domain: "FCNetwork", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL: \(urlString)"]))
        }
    }

}
