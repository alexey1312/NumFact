//
//  APINumManager.swift
//  NumFact
//
//  Created by Admin on 07/09/2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import Foundation

struct Type {
    let typeRandom: String
}

enum ForecastType: FinalURLPoint {
    case trivia(apiKey: String, type: Type)
    case year(apiKey: String, type: Type)
    case date(apiKey: String, type: Type)
    case math(apiKey: String, type: Type)
    
    var baseURL: URL {
        return URL(string: "http://numbersapi.com")!
    }
    
    var path: String {
        switch self {
        case .trivia(let apiKey, let type):
            return "/forecast/\(apiKey)/\(type.typeRandom)"
        case .year(let apiKey, let type):
            return "/forecast/\(apiKey)/\(type.typeRandom)"
        case .date(let apiKey, let type):
            return "/forecast/\(apiKey)/\(type.typeRandom)"
        case .math(let apiKey, let type):
            return "/forecast/\(apiKey)/\(type.typeRandom)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
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
        let request = ForecastType.date(apiKey: self.apiKey,
                                        type: type).request
        
        fetch(request: request, parse: { (json) -> CurrentNum? in
            if let dictionary = json["application/json"] as? [String: AnyObject] {
                return CurrentNum(JSON: dictionary)
            } else {
                return nil
            }
            
        }, completionHandler: completionHandler)
    }
}



//
//
//
//
//
////Определение ссылки
////        let formatURL = "?json"
////        let urlString = "http://numbersapi.com/random/year?json" + formatURL
//        let baseURL = URL(string: "http://numbersapi.com/")
//        let fullURL = URL(string: "random/year?json", relativeTo: baseURL)
//
//        //Создание сессии
//        let sessionconfiguration = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionconfiguration)
//
//        //Создание запроса
//        _ = URLRequest(url: fullURL!)
//        let dataTask = session.dataTask(with: fullURL!) { (data, response, error) in
//
//        }
//        dataTask.resume()
//    }
//
