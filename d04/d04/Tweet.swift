//
//  Tweet.swift
//  d04
//
//  Created by Maksym SALIUTA on 2/8/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import Foundation

struct Tweet: CustomStringConvertible{
    
    let name: String
    let date: String
    let text: String
    
    var description: String {
        return "\(name) \(text): \(date)"
    }
}
