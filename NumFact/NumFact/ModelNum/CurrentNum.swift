//
//  CurrentNum.swift
//  NumFact
//
//  Created by Admin on 07/09/2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import UIKit

struct CurrentNum {
    let text: String
    let found: Bool
    let number: Int
    let type: String
    let date: String?
    let year: Int?
}

extension CurrentNum: Codable {
    init?(JSON: [String: AnyObject]) {

        guard let text = JSON["text"] as? String,
            let found = JSON["found"] as? Bool,
            let number = JSON["number"] as? Int,
            let type = JSON["type"] as? String,
            let date = JSON["date"] as? String?,
            let year = JSON["year"] as? Int? else {
                return nil
        }
        self.text = text
        self.found = found
        self.number = number
        self.type = type
        self.date = date
        self.year = year
    }
}
