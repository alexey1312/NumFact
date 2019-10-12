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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBAction func buttonRandomTrivia(_ sender: UIButton) {
        toggleActivitiIndicator(on: true)
        getRandomTrivia()
    }
    
    @IBAction func buttonRandomYear(_ sender: UIButton) {
        toggleActivitiIndicator(on: true)
        getRandomYear()
    }
    
    @IBAction func buttonRandomDate(_ sender: UIButton) {
        toggleActivitiIndicator(on: true)
        getRandomDate()
    }
    
    @IBAction func buttonRandomMath(_ sender: UIButton) {
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
        refreshButton.isHidden = false
    }
    
    func toggleActivitiIndicator(on: Bool) {
        
        refreshButton.isHidden = on
        if on  {
            activityIndicator.startAnimating()
            timerStart(timeInterval: 10)
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    lazy var numManager = APINumManager(apiKey: "")
    
    let type = Type()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerStart(timeInterval: 10)
        getRandomDate()
    }
    
    func getRandomDate() {
        numManager.fetchCurrentDateWith(type: type) { (Result) in
            self.toggleActivitiIndicator(on: false)
            
            switch Result{
            case .Success(let currentNum):
                self.updateUIWith(currentNum: currentNum)
            case .Failure(let error as NSError):
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
        numManager.fetchCurrentYearWith(type: type) { (Result) in
            self.toggleActivitiIndicator(on: false)
            
            switch Result{
            case .Success(let currentNum):
                self.updateUIWith(currentNum: currentNum)
            case .Failure(let error as NSError):
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
        numManager.fetchCurrentTriviaWith(type: type) { (Result) in
            self.toggleActivitiIndicator(on: false)
            
            switch Result{
            case .Success(let currentNum):
                self.updateUIWith(currentNum: currentNum)
            case .Failure(let error as NSError):
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
        numManager.fetchCurrentMathaWith(type: type) { (Result) in
            self.toggleActivitiIndicator(on: false)
            
            switch Result{
            case .Success(let currentNum):
                self.updateUIWith(currentNum: currentNum)
            case .Failure(let error as NSError):
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
