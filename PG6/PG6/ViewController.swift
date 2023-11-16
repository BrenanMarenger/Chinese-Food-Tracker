//
//  ViewController.swift
//  PG6
//
//  Created by NMU Student on 11/16/23.
//

import UIKit
import WebKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var latTF:UITextField?
    @IBOutlet var longTF:UITextField?
    @IBOutlet var button:UIButton?
    @IBOutlet var wv:WKWebView?
    var locationManager = CLLocationManager ()
    
    var currentLong:Double?
    var currentLat:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        button?.addTarget(self, action: #selector (setCoord), for: .touchUpInside)
    }
    
    func locationManager (_ manager:CLLocationManager,didUpdateLocations locations:[CLLocation]) {
        let loc = locations[0]
        let coord = loc.coordinate
        currentLong = coord.longitude
        currentLat = coord.latitude
    }
    
    @IBAction func setCoord() {
        let letters = NSCharacterSet.letters
        var long:Float? = Float(longTF?.text! ?? "0")
        var lat:Float? = Float(latTF?.text! ?? "0") //-90 and 90
        
        if(lat! > 90 || lat! < -90) {
            lat = Float(currentLat!)
        }
        if(long! > 180 || long! < -180) {
            long = Float(currentLong!)
        }
        
        print(lat!, long!)
        
        var address = "https://www.google.com/maps/search/chinese+restaurant/@\(lat!),\(long!),13.5z"
        let url = URL (string:address)
        let requestObj = URLRequest (url:url!)
        wv!.load (requestObj)
    }


}

