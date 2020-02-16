//
//  DestinationViewController.swift
//  rush01
//
//  Created by Ekateryna LOPUKH on 2/16/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit
import MapKit

class DestinationViewController: UIViewController, MKMapViewDelegate,UISearchBarDelegate {
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    var request = MKDirections.Request()
    var selectedPin: MKPlacemark? = nil
    var startSearch = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var First: UILabel!
    @IBOutlet weak var Second: UILabel!
    @IBAction func addDeparture(_ sender: UIButton) {
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        startSearch.searchBar.delegate = self
        startSearch = UISearchController(searchResultsController: locationSearchTable)
        definesPresentationContext = true
        startSearch.searchResultsUpdater = locationSearchTable
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        present(startSearch, animated: true, completion: nil)
    }
    
    @IBAction func AddDest(_ sender: UIButton) {
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
               startSearch.searchBar.delegate = self
               startSearch = UISearchController(searchResultsController: locationSearchTable)
               definesPresentationContext = true
               startSearch.searchResultsUpdater = locationSearchTable
               locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
               present(startSearch, animated: true, completion: nil)
    }
    @IBAction func DoneButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "Done", sender: self)
    }
    
    
    override func viewDidLoad() {
        request.source = nil
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.isHidden = true
//        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.7127, longitude: -74.0059), addressDictionary: nil))
//        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667), addressDictionary: nil))
        //request.requestsAlternateRoutes = true
        //request.transportType = .automobile
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let map = segue.destination as! ViewController
        map.request = self.request
    }
}
extension DestinationViewController: HandleMapSearch {
func dropPinZoomIn(placemark:MKPlacemark){
    mapView.removeAnnotations(mapView.annotations)
    let overlays = mapView.overlays
    mapView.removeOverlays(overlays)
    
    if request.source == nil {
        request.source =  MKMapItem(placemark:placemark)
        self.First.text = request.source?.placemark.title
    }
    else
    {
        request.destination = MKMapItem(placemark:placemark)
        self.Second.text = request.destination?.placemark.title
        request.transportType = .automobile
    }
    }}
extension DestinationViewController : CLLocationManagerDelegate {

func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error:: \(error.localizedDescription)")
}

func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
        locationManager.requestLocation()
    }
}

func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }
}

