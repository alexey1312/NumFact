//
//  APINumManager.swift
//  NumFact
//
//  Created by Admin on 07/09/2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import Foundation

struct TypeRandom {
    let typeRandomTrivia: String = "random/trivia?json"
    let typeRandomYear: String = "random/year?json"
    let typeRandomDate: String = "random/date?json"
    let typeRandomMath: String = "random/math?json"
}

enum RandomNumType: FinalURLPoint {
    case trivia(type: TypeRandom)
    case year(type: TypeRandom)
    case date(type: TypeRandom)
    case math(type: TypeRandom)

    var baseURL: URL {
        return URL(string: "http://numbersapi.com")!
    }

    var path: String {
        switch self {
        case .trivia(let type):
            return "/\(type.typeRandomTrivia)"
        case .year(let type):
            return "/\(type.typeRandomYear)"
        case .date(let type):
            return "/\(type.typeRandomDate)"
        case .math(let type):
            return "/\(type.typeRandomMath)"
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
    }()

    init(sessionConfiguration: URLSessionConfiguration) {
        self.sessionconfiguration = sessionConfiguration
    }

    func fetchCurrentDateWith(type: TypeRandom,
                              completionHandler: @escaping (APIResult<CurrentNum>) -> Void) {
        let requestDate = RandomNumType.date(type: type).request

        fetch(request: requestDate, parse: { (json) -> CurrentNum? in
            return CurrentNum(JSON: json)

        }, completionHandler: completionHandler)
    }

    func fetchCurrentYearWith(type: TypeRandom,
                              completionHandler: @escaping (APIResult<CurrentNum>) -> Void) {
        let requestYear = RandomNumType.year(type: type).request

        fetch(request: requestYear, parse: { (json) -> CurrentNum? in
            return CurrentNum(JSON: json)

        }, completionHandler: completionHandler)
    }

    func fetchCurrentTriviaWith(type: TypeRandom,
                                completionHandler: @escaping (APIResult<CurrentNum>) -> Void) {
        let requestYear = RandomNumType.trivia(type: type).request

        fetch(request: requestYear, parse: { (json) -> CurrentNum? in
            return CurrentNum(JSON: json)

        }, completionHandler: completionHandler)
    }

    func fetchCurrentMathaWith(type: TypeRandom,
                               completionHandler: @escaping (APIResult<CurrentNum>) -> Void) {
        let requestYear = RandomNumType.math(type: type).request

        fetch(request: requestYear, parse: { (json) -> CurrentNum? in
            return CurrentNum(JSON: json)

        }, completionHandler: completionHandler)
    }
}
