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
    
    @IBOutlet weak var result_LBL: UILabel!
    
    
    @IBAction func ac_BTN(_ sender: UIButton) {
        result_LBL.text = "0";
    }
    
    @IBAction func first_BTN(_ sender: UIButton) {
        result_LBL.text = "1";
    }
    
    @IBAction func second_BTN(_ sender: UIButton) {
        result_LBL.text = "2";
    }
    
    @IBAction func third_BTN(_ sender: UIButton) {
        result_LBL.text = "3";
    }

    @IBAction func fourth_BTN(_ sender: UIButton) {
        result_LBL.text = "4";
    }
    
    @IBAction func fifth_BTN(_ sender: UIButton) {
        result_LBL.text = "5";
    }
    
    @IBAction func sixth_BTN(_ sender: UIButton) {
        result_LBL.text = "6";
    }
    
    @IBAction func seventh_BTN(_ sender: UIButton) {
        result_LBL.text = "7";
    }
    
    @IBAction func eights_BTN(_ sender: UIButton) {
        result_LBL.text = "8";
    }
    
    @IBAction func nineth_BTN(_ sender: UIButton) {
        result_LBL.text = "0";
    }
    
    @IBAction func zero_BTN(_ sender: UIButton) {
        result_LBL.text = "0";
    }
}

