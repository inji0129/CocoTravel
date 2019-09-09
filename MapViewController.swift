//
//  MapViewController.swift
//  CoCoTravel
//
//  Created by Yehoon on 4/14/19.
//  Copyright © 2019 Yehoon Joo. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    var markers = [GMSMarker]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cities = ["Tokyo", "LA", "Vancouver", "Seoul", "Boston", "Beijing", "Seattle", "Atlanta", "Mexico City", "Toronto", "San Juan", "Kuala Lumpur", "Langkawi", "Bali"]
        var countries = ["Japan", "United States", "Canada", "South Korea", "United States", "China", "United States", "United States", "Mexico", "Canada", "Puerto Rico", "Malaysia", "Malaysia", "Indonesia"]
        var latitudes = [35.6762, 34.0522, 49.2827, 37.5665, 42.3601, 39.9042, 47.6062, 33.7490, 19.4326, 43.6532, 18.4655, 3.1390, 6.3500, 8.3405]
        var longitudes = [139.6503, -118.2437, -123.1207, 126.9780, -71.0589, 116.4074, -122.3321, -84.3880, -99.1332, -79.3832, -66.1057, 101.6869, 99.8000, 115.0920]

        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        var bounds = GMSCoordinateBounds()
        // Creates a marker in the center of the map.
        for i in 0..<cities.count {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: latitudes[i], longitude: longitudes[i])
            marker.title = cities[i]
            marker.snippet = countries[i]
            marker.icon = GMSMarker.markerImage(with: .random())
            marker.map = mapView
            markers.append(marker)
            bounds = bounds.includingCoordinate(marker.position)
        }
        
        mapView.setMinZoom(1, maxZoom: 15)//prevent to over zoom on fit and animate if bounds be too small
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
        mapView.animate(with: update)
        
        mapView.setMinZoom(1, maxZoom: 20) // allow the user zoom in more than level 15 again
    }
    
    @IBAction func homeButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode { // modal segue
            dismiss(animated: true, completion: nil)
        } else { // show segue
            navigationController!.popViewController(animated: true)
        }
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
