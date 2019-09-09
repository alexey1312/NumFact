//
//  APINumManager.swift
//  NumFact
//
//  Created by Admin on 07/09/2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import Foundation

struct Type {
//    let typeRandomTrivia: String = "random/trivia?json"
//    let typeRandomYear: String = "random/year?json"
    let typeRandomDate: String
//    let typeRandomMath: String = "random/math?json"
}

enum RandomNumType: FinalURLPoint {
//    case trivia(apiKey: String, type: Type)
//    case year(apiKey: String, type: Type)
    case date(apiKey: String, type: Type)
//    case math(apiKey: String, type: Type)
    
    var baseURL: URL {
        return URL(string: "http://numbersapi.com/random/date?json")!
//        return URL(string: "http://numbersapi.com")!
    }
    
    var path: String {
        switch self {
//        case .trivia(let apiKey, let type):
//            return "\(apiKey)/\(type.typeRandomTrivia)"
//        case .year(let apiKey, let type):
//            return "\(apiKey)/\(type.typeRandomYear)"
        case .date(let apiKey, let type):
            return "\(apiKey)\(type.typeRandomDate)"
//            return "\(apiKey)/\(type.typeRandomDate)"
//        case .math(let apiKey, let type):
//            return "\(apiKey)/\(type.typeRandomMath)"
        }
    }
    
    var request: URLRequest {
//        let url = URL(string: path, relativeTo: baseURL)
        let url = URL(string: "http://numbersapi.com/random/date?json")
        return URLRequest(url: url!)
    }
    
}

final class APINumManager: APIManager {
    var sessionconfiguration: URLSessionConfiguration
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionconfiguration)
    } ()
    
    let apiKey: String
    
    init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
        self.sessionconfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    
    func fetchCurrentNumWith(type: Type,
                             completionHandler: @escaping (APIResult<CurrentNum>) -> Void) {
        let request = RandomNumType.date(apiKey: self.apiKey,
                                        type: type).request
        
        fetch(request: request, parse: { (json) -> CurrentNum? in
            if let dictionary = json as? [String: AnyObject] {
                return CurrentNum(JSON: dictionary)
            } else {
                return nil
            }
            
        }, completionHandler: completionHandler)
    }
}