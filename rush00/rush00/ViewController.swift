//
//  ViewController.swift
//  rush00
//
//  Created by Maksym SALIUTA on 2/9/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    private let UID = "e326e85f594324d218d265f5de127271189fb174e6299268ad3bc5446bc44baa"
    private let SECRET = "5717cacb27a817a6cb0f272d5324b8c73cdad9c4259aab9fb21a04e92a6c6332"
    private let siteUrl = "msaliuta://msaliuta"
    
    private var auth: ASWebAuthenticationSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://api.intra.42.fr/oauth/authorize?client_id=\(UID)&redirect_uri=\(siteUrl)&response_type=code";
        auth = ASWebAuthenticationSession(url: URL(string: urlString)!, callbackURLScheme: siteUrl) {
            (data, error) in
            print(data)
            if data != nil {
                let session = URLSession.shared
                let url = NSURL(string: "https://api.intra.42.fr/oauth/token")
                let request = NSMutableURLRequest(url: url! as URL)
                request.httpBody = "grant_type=authorization_code&client_id=\(self.UID)&client_secret=\(self.SECRET)&\((data?.query!)!)&redirect_uri=\(self.siteUrl)".data(using: String.Encoding.utf8)
                request.httpMethod = "POST"
                session.dataTask(with: request as URLRequest) {
                    (data, res, err) in
                    if err != nil {
                        return
                    }
                    do {
                        if let dict: NSDictionary = try JSONSerialization.jsonObject(with: data!) as? NSDictionary {
                            print(dict)
                            self.token = dict["access_token"] as? String
                               global_token.token = self.token
                        }
                    } catch {
                        print("Error")
                    }
                }.resume()
            }
        }
        auth?.presentationContextProvider = self
        auth?.start()
        // Do any additional setup after loading the view.
    }
    
}

@available(iOS 13.0, *)
extension ViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
}

