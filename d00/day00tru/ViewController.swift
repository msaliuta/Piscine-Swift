//
//  ViewController.swift
//  day00tru
//
//  Created by Maksym SALIUTA on 2/3/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var oper = false;
    var curVal:Int = 0;
    var val2:Int = 0;
    var act = false;
    var type = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func test(_ sender: UIButton) {
        print(sender.tag)
        if (oper) {
            oper = false;
            curVal = 0;

            if (type == 16) {
                val2 = 0;
            }
            else {
                act = true;
            }
        }
        if ((curVal >= 0 && (curVal * 10 + sender.tag) < 2147483648) || (curVal < 0 && (curVal * 10 - sender.tag) > -2147483649)) {
            if (curVal < 0) {
                curVal = curVal * 10 - sender.tag;
            }
            else {
                curVal = curVal * 10 + sender.tag;
            }
        }
        else {
            if (curVal >= 0) {
                curVal = 2147483647;
                print("Error : max Int");
            }
            else {
                curVal = -2147483648;
                print("Error : min Int");
            }
        }
        result_LBL.text = String(curVal);
    }
    
    func action() {
        if (type == 12) {
            if (curVal + val2 > 2147483647) {
                curVal = 2147483647;
                print("Error : max Int");
            }
            else if (curVal + val2 < -2147483648) {
                curVal = -2147483648;
                print("Error : min Int");
            }
            else {
                curVal = curVal + val2;
            }
        }
        else if (type == 13) {
            if (curVal * val2 > 2147483647) {
                curVal = 2147483647;
                print("Error : max Int");
            }
            else if (curVal * val2 < -2147483648) {
                curVal = -2147483648;
                print("Error : min Int");
            }
            else {
                curVal = curVal * val2;
            }
        }
        else if (type == 14) {
            if (val2 - curVal > 2147483647) {
                curVal = 2147483647;
                print("Error : max Int");
            }
            else if (val2 - curVal < -2147483648) {
                curVal = -2147483648;
                print("Error : min Int");
            }
            else {
                curVal = val2 - curVal;
            }
        }
        else if (type == 15) {
            curVal = val2 / curVal;
        }
        result_LBL.text = String(curVal);
    }
    
    @IBAction func operation(_ sender: UIButton) {
        print(sender.tag)
        oper = true;
        if (act || sender.tag == 16) {
            if (type == 15 && curVal == 0) {
                result_LBL.text = "Error";
                curVal = 0;
                val2 = 0;
                type = 0;
                act = false;
                oper = false;
            }
            else {
                action()
            }
            act = false;
            val2 = curVal;
        }
        else {
            val2 = curVal;
        }
        
        type = sender.tag;
    }
    
    @IBAction func negOp(_ sender: UIButton) {
        print("NEG pressed")
        if ((curVal < 0 && curVal * -1 < 2147483648) || (curVal >= 0 && curVal * -1 > -2147483649)) {
            curVal = -curVal;
        }
        else {
            if (curVal < 0) {
                curVal = 2147483647;
            }
            else {
                curVal = -2147483648;
            }
            print("Error : max or min Int");
        }
        result_LBL.text = String(curVal);
    }
    
    
    @IBAction func clean(_ sender: UIButton) {
        print("AC pressed")
        curVal = 0;
        val2 = 0;
        result_LBL.text = "0";
        type = 0;
        act = false;
        oper = false;
    }
    
    @IBOutlet weak var result_LBL: UILabel!

}
