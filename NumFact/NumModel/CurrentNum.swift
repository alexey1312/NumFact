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
    let year: Int
    let number: Int
    let found: Bool
    let type: String
}

extension CurrentNum: JSONDecodable{
    init?(JSON: [String : AnyObject]) {
        guard let text = JSON["text"] as? String,
        let year = JSON["year"] as? Int,
        let number = JSON["number"] as? Int,
        let found = JSON["found"] as? Bool,
            let type = JSON["type"] as? String else {
                return nil
        }
        self.text = text
        self.year = year
        self.number = number
        self.found = found
        self.type = type
    }
}
