//
//  SecondViewController.swift
//  APM
//
//  Created by Maksym SALIUTA on 2/7/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import Foundation

import UIKit

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var imageView : UIImageView?
    var image : UIImage?
    
    let items = ["1", "2", "3"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
//        super.viewDidLoad()
//        image = UIImage(named: "nasa1")
//        imageView = UIImageView(image: image)
//        //collectionView.addSubview(im)
//
        // Do any additional setup after loading the view.
    }
    
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
      cell.backgroundColor = .black
      return cell
    }
    
}
