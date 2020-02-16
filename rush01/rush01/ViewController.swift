//
//  ViewController.swift
//  rush01
//
//  Created by Maksym SALIUTA on 2/16/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class ViewController: UIViewController, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    var selectedPin: MKPlacemark? = nil
    var request = MKDirections.Request()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func meButtn(_ sender: UIButton) {
        if (CLLocationManager.authorizationStatus() != .authorizedWhenInUse) {
            let alert = UIAlertController(title: "Error", message: "Can not update location because application has no permission", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true)
        } else {
            let region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    @IBAction func unWindSegue(segue: UIStoryboardSegue){
        let directions = MKDirections(request: request)
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }

            for route in unwrappedResponse.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
          }
    }
}

extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            //            let span = MKCoordinateRegionMakeWithDistance(location, 200, 200)
            //            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            //            mapView.setRegion(region, animated: true)
            zoomOnLocation(location: location.coordinate)
        }
    }
    
    func zoomOnLocation(location:CLLocationCoordinate2D) {
        var mapRegion = MKCoordinateRegion()
        mapRegion.center = location
        mapRegion.span.latitudeDelta = 0.01;
        mapRegion.span.longitudeDelta = 0.01;
        mapView.setRegion(mapRegion, animated: true)
    }
    
}

extension ViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let overlays = mapView.overlays
        mapView.removeOverlays(overlays)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        let titleString:String = placemark.description
        let splittedText = titleString.components(separatedBy: ",")
        if splittedText.count > 1 {
            annotation.title = splittedText[0] + ", " + splittedText[1]
        }
        else {
            annotation.title = placemark.title
            
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

