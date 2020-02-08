//
//  ViewController.swift
//  d04
//
//  Created by Maksym SALIUTA on 2/8/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var token: String?
    var apiController : APIController?
    var tweets: [Tweet]?
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTweets(string: "mem")
        // Do any additional setup after loading the view.
    }
    
    func searchTweets(string: String) {
            let queue = DispatchQueue.global(qos: DispatchQoS.userInitiated.qosClass);
            queue.async {
                self.getAccessToken()
                if let t = self.token {
                    self.apiController = APIController(delegate: self, token: t)
                    self.apiController?.getTweets(search: string)
                }
            }
        }
        
        func getAccessToken() {
            let CUSTOMER_KEY = "wsuLtDF5wPHeJ0m3egZE2pOwJ"
            let CUSTOMER_SECRET = "lL7nnZDBX75zqYQwo3PYVbf3s25Z7wk2ON7bCGa9li1k90qTeK"
            let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            let url = URL(string: "https://api.twitter.com/oauth2/token")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("Basic " + BEARER!, forHTTPHeaderField: "Authorization")
            request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
            let group = DispatchGroup()
            let task = URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                guard error == nil, let data = data else { return }
                do {
                    guard let dic = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary else {
                        return
                    }
                    guard dic["errors"] as? [Any] == nil else {
                        DispatchQueue.main.async {
                            self.handleError(error: NSError(domain: "An error occurred while loading tweets", code: 0))
                        }
                        return
                    }
                    self.token = dic["access_token"] as? String
                } catch {
                    print(error.localizedDescription)
                }
                group.leave()
            }
            group.enter()
            task.resume()
            group.wait()
        }
    }

    extension ViewController: APITwitterDelegate {
        func processTweets(tweets: [Tweet]) {
            self.tweets = tweets
            tableView.reloadData()
        }
        
        func handleError(error: NSError) {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    extension ViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tweets?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            cell.tweet = tweets![indexPath.row]
            return cell
        }
    }

    extension ViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let search = textField.text {
                if (textField.text!.isEmpty == false) {
                    processTweets(tweets: []);
                    searchTweets(string: search)
                    return (true);
                }
            }
            return (false);
        }
}

