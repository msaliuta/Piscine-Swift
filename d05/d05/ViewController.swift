//
//  ViewController.swift
//  d05
//
//  Created by Maksym SALIUTA on 2/10/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var pins = [MKPointAnnotation()]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        myMap.showsUserLocation = true
        myMap.delegate = self
        
        myMap.addAnnotations(adrs)
        
        zoomOnLocation(location: adrs[0].coordinate)
        // Do any additional setup after loading the view.
    }

    func zoomOnLocation(location:CLLocationCoordinate2D) {
        var mapRegion = MKCoordinateRegion()
        mapRegion.center = location
        mapRegion.span.latitudeDelta = 0.01;
        mapRegion.span.longitudeDelta = 0.01;
        myMap.setRegion(mapRegion, animated: true)
    }

}

