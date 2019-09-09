//
//  ViewController.swift
//  NumFact
//
//  Created by Admin on 07/09/2019.
//  Copyright © 2019 Aleksei Kakoulin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        toggleActivitiIndicator(on: true)
        getRandomWeather()
    }
    //Работа с индикатором
    var timer = Timer()
    func timerStart(timeInterval: Double) {
        //Запустить таймер
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
//            timerStart(timeInterval: 10)
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    lazy var numManager = APINumManager(apiKey: "")
//    let type = Type(typeRandomDate: "random/date?json")
    let type = Type(typeRandomDate: "")

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        timerStart(timeInterval: 10)
        getRandomWeather()
        
    }
    
    func getRandomWeather() {
        numManager.fetchCurrentNumWith(type: type) { (Result) in
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
        self.numberLabel.text = String(currentNum.number)
        self.textLabel.text = currentNum.text
    }
    
    @objc func stopLoadingSpinner() {
        self.activityIndicator.stopAnimating()
    }
}
