//
//  SecondViewController.swift
//  APM
//
//  Created by Maksym SALIUTA on 2/7/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var myImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myScroll.minimumZoomScale = 1.0
        self.myScroll.maximumZoomScale = 6.0
        
        // Do any additional setup after loading the view.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.myImg
    }
    
}
