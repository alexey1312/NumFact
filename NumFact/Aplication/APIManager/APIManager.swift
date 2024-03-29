//
//  APIManager.swift
//  NumFact
//
//  Created by Admin on 07/09/2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void

protocol JSONDecodable {
    init?(JSON: [String: AnyObject])
}

protocol FinalURLPoint {
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

protocol APIManager {
    var sessionconfiguration: URLSessionConfiguration { get } //session configuration
    var session: URLSession { get } //session based sessionconfiguration

    func JSONTaskWith(request: URLRequest,
                      completionHandler: @escaping JSONCompletionHandler) -> JSONTask
    func fetch<T: JSONDecodable>(request: URLRequest,
                                 parse: @escaping ([String: AnyObject]) -> T?,
                                 completionHandler: @escaping(APIResult<T>) -> Void)
    //Optional
    //    init(sessionconfiguration: URLSessionConfiguration)
}

extension APIManager {
    func JSONTaskWith(request: URLRequest,
                      completionHandler: @escaping JSONCompletionHandler) -> JSONTask {

        let dataTask = session.dataTask(with: request) { (data, response, error) in

            guard let HTTPResponse = response as? HTTPURLResponse else {

                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                let error = NSError(domain: networkingErrorDomain,
                                    code: missingHTTPResponseError,
                                    userInfo: userInfo)

                completionHandler(nil, nil, error)
                return
            }

            if data == nil {
                if let error = error {
                    completionHandler(nil, HTTPResponse, error)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                        completionHandler(json, HTTPResponse, nil)
                    } catch let error as NSError {
                        completionHandler(nil, HTTPResponse, error)
                    }
                default:
                    print("We have got response status \(HTTPResponse.statusCode)")
                }
            }
        }
        return dataTask
    }

    func fetch<T>(request: URLRequest,
                  parse: @escaping ([String: AnyObject]) -> T?,
                  completionHandler: @escaping (APIResult<T>) -> Void) {

        let dataTask = JSONTaskWith(request: request) { (json, _, error) in
            DispatchQueue.main.async(execute: {
                guard let json = json else {
                    if let error = error {
                        completionHandler(.failure(error))
                    }
                    return
                }
                if let value = parse(json) {
                    completionHandler(.success(value))
                } else {
                    let error = NSError(domain: networkingErrorDomain, code: 200, userInfo: nil)
                    completionHandler(.failure(error))
                }
            })
        }
        dataTask.resume()
    }
}
