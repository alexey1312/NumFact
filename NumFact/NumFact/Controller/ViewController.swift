//
//  ViewController.swift
//  NumFact
//
//  Created by Admin on 07/09/2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var typeRandom = TypeRandom()
    lazy var numManager = APINumManager(sessionConfiguration: .default)

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var buttonDate: UIButton! {
        didSet {
            buttonDate.layer.cornerRadius = 20
            buttonDate.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            buttonDate.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            buttonDate.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            buttonDate.layer.shadowOpacity = 2.0
            buttonDate.layer.shadowRadius = 2.0
        }
    }

    @IBOutlet weak var buttonYear: UIButton! {
        didSet {
            buttonYear.layer.cornerRadius = 20
            buttonYear.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            buttonYear.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            buttonYear.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            buttonYear.layer.shadowOpacity = 2.0
            buttonYear.layer.shadowRadius = 2.0
        }
    }

    @IBOutlet weak var buttonMath: UIButton! {
        didSet {
            buttonMath.layer.cornerRadius = 20
            buttonMath.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            buttonMath.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            buttonMath.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            buttonMath.layer.shadowOpacity = 2.0
            buttonMath.layer.shadowRadius = 2.0
        }
    }

    @IBOutlet weak var buttonTrivia: UIButton! {
        didSet {
            buttonTrivia.layer.cornerRadius = 20
            buttonTrivia.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            buttonTrivia.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            buttonTrivia.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            buttonTrivia.layer.shadowOpacity = 2.0
            buttonTrivia.layer.shadowRadius = 2.0
        }
    }

    @IBAction func buttonRandomTriviaAction(_ sender: UIButton) {
        toggleActivitiIndicator(on: true)
        getRandomTrivia()
    }

    @IBAction func buttonRandomYearAction(_ sender: UIButton) {
        toggleActivitiIndicator(on: true)
        getRandomYear()
    }

    @IBAction func buttonRandomDateAction(_ sender: UIButton) {
        toggleActivitiIndicator(on: true)
        getRandomDate()
    }

    @IBAction func buttonRandomMathAction(_ sender: UIButton) {
        toggleActivitiIndicator(on: true)
        getRandomMath()
    }

    //Timer
    var timer = Timer()
    func timerStart(timeInterval: Double) {

        //Play timer
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(stopLoadingSpinner),
                                     userInfo: nil,
                                     repeats: false)
        buttonDate.isHidden = false
    }

    func toggleActivitiIndicator(on: Bool) {

        buttonDate.isHidden = on
        if on {
            activityIndicator.startAnimating()
            timerStart(timeInterval: 10)
        } else {
            activityIndicator.stopAnimating()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        timerStart(timeInterval: 10)
        getRandomDate()
    }

    func getRandomDate() {
        numManager.fetchCurrentDateWith(type: typeRandom) { (result) in
            self.toggleActivitiIndicator(on: false)

            switch result {
            case .success(let currentNum):
                self.updateUIWith(currentNum: currentNum)
            case .failure(let error as NSError):
                let alertController = UIAlertController(title: "Unable to get data",
                                                        message: "\(error.localizedDescription)",
                    preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: nil)
                alertController.addAction(okAction)

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    func getRandomYear() {
        numManager.fetchCurrentYearWith(type: typeRandom) { (result) in
            self.toggleActivitiIndicator(on: false)

            switch result {
            case .success(let currentNum):
                self.updateUIWith(currentNum: currentNum)
            case .failure(let error as NSError):
                let alertController = UIAlertController(title: "Unable to get data",
                                                        message: "\(error.localizedDescription)",
                    preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: nil)
                alertController.addAction(okAction)

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    func getRandomTrivia() {
        numManager.fetchCurrentTriviaWith(type: typeRandom) { (result) in
            self.toggleActivitiIndicator(on: false)

            switch result {
            case .success(let currentNum):
                self.updateUIWith(currentNum: currentNum)
            case .failure(let error as NSError):
                let alertController = UIAlertController(title: "Unable to get data",
                                                        message: "\(error.localizedDescription)",
                    preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: nil)
                alertController.addAction(okAction)

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    func getRandomMath() {
        numManager.fetchCurrentMathaWith(type: typeRandom) { (result) in
            self.toggleActivitiIndicator(on: false)

            switch result {
            case .success(let currentNum):
                self.updateUIWith(currentNum: currentNum)
            case .failure(let error as NSError):
                let alertController = UIAlertController(title: "Unable to get data",
                                                        message: "\(error.localizedDescription)",
                    preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: nil)
                alertController.addAction(okAction)

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    func updateUIWith(currentNum: CurrentNum) {

        if currentNum.year == nil {
            self.dateLabel.text = "Number: " + String(currentNum.number)
        } else {
            self.dateLabel.text = "Date: " + String(currentNum.year ?? 0)
        }
        self.textLabel.text = currentNum.text
    }

    @objc func stopLoadingSpinner() {
        self.activityIndicator.stopAnimating()
    }
}
