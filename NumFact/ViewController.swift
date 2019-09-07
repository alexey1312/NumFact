//
//  ViewController.swift
//  NumFact
//
//  Created by Admin on 07/09/2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentNum = CurrentNum(text: "Просто текст",
                                    found: true,
                                    number: 2018,
                                    type: "date",
                                    date: "2018")
        updateUIWith(currentNum: currentNum)
    }
    
    func updateUIWith(currentNum: CurrentNum) {
        self.dateLabel.text = currentNum.date
        self.textLabel.text = currentNum.text
        }
}
