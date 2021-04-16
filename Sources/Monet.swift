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
    public static let shared: Monet = { return Monet(urlSession: .shared) }()
    var urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func request(from urlString: URLConvertible,
                 using method: HTTPMethod = .get,
                 sending headers: Headers? = nil,
                 and parameters: Parameters? = nil,
                 setting timeout: TimeInterval = 30,
                 cachePolicy: URLRequest.CachePolicy = .reloadIgnoringCacheData,
                 handler: @escaping(Data?, URLResponse?, Error?) -> Void) {

        do {
            let url = try urlString.toUrl()
            var urlRequest: URLRequest = URLRequest(url: url,
                                                    cachePolicy: cachePolicy,
                                                    timeoutInterval: timeout)

            if let headers = headers {
                for (key, value) in headers {
                    urlRequest.setValue(value, forHTTPHeaderField: key)
                }
            }

            URLSession.shared.dataTask(with: urlRequest,
                                       completionHandler: { (data, response, error) in
                                        handler(data, response, error)
                                       }).resume()
        } catch {
            handler(nil, nil, error)
        }
    }

}
