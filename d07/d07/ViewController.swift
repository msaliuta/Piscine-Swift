//
//  ViewController.swift
//  d07
//
//  Created by Maksym SALIUTA on 2/13/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit
import RecastAI
import CoreLocation
import ForecastIO

class ViewController: UIViewController {

    @IBOutlet weak var InputText: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    var maksbot : RecastAIClient?
    var DS_key : DarkSkyClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.maksbot = RecastAIClient(token : "aab282409ae596e9bbe5a46071318de9", language: "en")
        self.DS_key = DarkSkyClient(apiKey: "31bcbf37d9dfc5d6b34bbd5a22082f1e")
        self.DS_key?.units = .si
    }
    
    @IBAction func reqButton(_ sender: Any) {
        let inputText = InputText.text!
            if inputText == "" {
                self.displayAlert(message: "Input something")
            }
            else {
                self.maksbot?.textRequest(inputText, successHandler: {
                    resp in
                    guard let location = resp.get(entity: "location") else {
                        self.displayAlert(message: "Can't find city")
                        return
                    }
                    guard let latitude = location["lat"] else {
                        self.displayAlert(message: "Latutude missing")
                        return
                    }
                    guard let longitude = location["lng"] else {
                        self.displayAlert(message: "Longitude missing")
                        return
                    }
                    
                    let coordinates = CLLocationCoordinate2D(latitude: latitude as! CLLocationDegrees, longitude: longitude as! CLLocationDegrees)
                    
                    self.DS_key!.language = .english
                    self.DS_key!.getForecast(location: coordinates) {
                        res in
                        
                        switch res {
                        case .success(let curForcast, _):
                            guard let weather = curForcast.currently?.summary else {self.displayAlert(message: "Data not found"); return}
                            guard let temp = curForcast.currently?.temperature else {self.displayAlert(message: "Data not found"); return}
                            DispatchQueue.main.async {
                                self.outputLabel.text = "Temperature: \(Int((temp))), Weather: \(weather)"
                            }
                        case .failure(_):
                            self.displayAlert(message: "Error")
                        }
                    }
                }, failureHandle: {
                    (err) in
                    print(err.localizedDescription)
                })
            }
        }
}

extension UIViewController {
    func displayAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

