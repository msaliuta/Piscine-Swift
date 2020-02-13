//
//  sourceList.swift
//  d05
//
//  Created by Maksym SALIUTA on 2/10/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import Foundation
import MapKit

class Pin: MKPointAnnotation {
    init(title:String, subtitle:String, coordinate: CLLocationCoordinate2D ) {
        super.init()
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

var adrs: [Pin] = [
    Pin(title: "Unit", subtitle: "My beautiful school", coordinate: CLLocationCoordinate2D(latitude: 50.468920, longitude: 30.462346))
]
