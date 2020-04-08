

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let images: [URL] = [
        URL(string: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/jsc2020e004627.jpeg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/49496215481_3028a41114_k.jpg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/49493580676_2fde6bc677_k.jpg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/49395543128_bc6c04732c_k.jpg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/20200121_jk34134.jpg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/49465891157_cd579b94f0_k.jpg")!,

    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: self.images[indexPath.row])
            if data != nil {
                DispatchQueue.main.async {
                    cell.loading.hidesWhenStopped = true
                    cell.loading.stopAnimating()
                    cell.image.image = UIImage(data: data!)
                }
            }
            else {
                let alert = UIAlertController(title: "Error", message: "Can not access to \(self.images[indexPath.row])", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        cell.loading.startAnimating()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let seg = segue.destination as! ImageViewController
        let cell = sender! as! CollectionViewCell
        if cell.image.image != nil {
            seg.image = cell.image.image!
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Photo can not be displayed", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

