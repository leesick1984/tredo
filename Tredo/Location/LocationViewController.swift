//
//  LocationViewController.swift
//  Tredo
//
//  Created by Alexander Lee on 26.12.2021.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var locationButton: UIButton!

    private var locationManager:CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()

    }
    func stopUpdate() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.stopUpdatingLocation()
    }
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        let tag = sender.tag
        if tag == 1 {
            sender.tag = 0
            locationButton.setTitle("Start spy", for: .normal)
            stopUpdate()
        } else {
            sender.tag = 1
            locationButton.setTitle("Stop spy", for: .normal)
            getUserLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationField.text = "Lat : \(location.coordinate.latitude) \nLng : \(location.coordinate.longitude)"
        }
    }
    
}
