//
//  ViewController.swift
//  APM
//
//  Created by Maksym SALIUTA on 2/7/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let items = ["https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/49421494311_c8b2264dbe_k.jpg", "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/ksc-20200119-ph-awg07_0011_large.jpg", "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/potw2002a.jpg", "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/s20-005_core_stage_installation_2718.jpg"]
    
    override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
     }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.myPhoto.load(url: URL(string: items[indexPath.item])!)
        
        return cell
    }
    

 
    

    
    
}

extension UIImageView {
  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
}
