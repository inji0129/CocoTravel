//
//  MapsViewController.swift
//  TravelWithFriends
//
//  Created by Yehoon on 4/14/19.
//  Copyright © 2019 Yehoon Joo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapsViewController: UIViewController {
    
    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        let location = CLLocationCoordinate2DMake(48.88182, 2.43952)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        
        annotation.title = "Pizza Pistonte"
        
        annotation.subtitle = "Luna Rossa"
        
        Map.addAnnotation(annotation)
        
        // Do any additional setup after loading the view.
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

