//
//  ViewController.swift
//  day00tru
//
//  Created by Maksym SALIUTA on 2/3/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func test(_ sender: UIButton) {
        let nbr:Int? = Int(result_LBL.text!)
        
        if (nbr != 0){
            result_LBL.text! += String(sender.tag)
        }
        else {
            result_LBL.text! = String(sender.tag)
        }
    }
    
    
    @IBAction func clean(_ sender: UIButton) {
        result_LBL.text = "0";
    }
    
    @IBOutlet weak var result_LBL: UILabel!

}

