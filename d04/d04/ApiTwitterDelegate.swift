//
//  ApiTwitterDelegate.swift
//  d04
//
//  Created by Maksym SALIUTA on 2/8/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: class {
    func processTweets(tweets: [Tweet])
    func handleError(error: NSError)
}
