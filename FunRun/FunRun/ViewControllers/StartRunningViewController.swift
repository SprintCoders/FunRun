//
//  StartRunningViewController.swift
//  FunRun
//
//  Created by DINGKaile on 11/14/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StartRunningViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var bgMapView: MKMapView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var typeSelector: UISegmentedControl!
    @IBOutlet weak var startButton: UIButton!
    
    
    var locationManager: CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // self.hidesBottomBarWhenPushed = true
        
        // Setup the avatarImage
        let side = self.avatarImage.frame.width
        self.avatarImage.layer.cornerRadius = side/2.0
        self.avatarImage.clipsToBounds = true
        
        // Setup the startButton
        self.startButton.layer.borderWidth = 5.0
        let startTextColor = self.startButton.currentTitleColor
        self.startButton.layer.borderColor = startTextColor.cgColor
        self.startButton.layer.cornerRadius = 5.0
        self.startButton.clipsToBounds = true
        // self.startButton.addTarget(self, action: #selector(startRunning), for: UIControlEvents.touchUpInside)
        
        // Setup the MapView
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestWhenInUseAuthorization()
        self.bgMapView.showsUserLocation = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /* MARK: - Navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "StartToRunning" {
            let DuringRunningVC = segue.destination as! DuringRunningViewController
            // DuringRunningVC = DuringRunningViewController()
            DuringRunningVC.accumulatedTime = 0
        }
    }
    
    
    /* MARK: - MapView functions */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            self.bgMapView.setRegion(region, animated: true)
        }
    }
    
    
    /*
    /* MARK: - Button function */
    func startRunning() {
        
        self.performSegue(withIdentifier: "StartToRunning", sender: self)
    }
    */
    
    

}
