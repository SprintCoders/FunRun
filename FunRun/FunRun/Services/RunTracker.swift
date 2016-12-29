//
//  RunTracker.swift
//  FunRun
//
//  Created by DINGKaile on 11/30/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import Foundation
// import UIKit
import CoreLocation

@objc protocol RunTrackerDelegate: class {
    @objc optional func RunTrackerUpdate(newDistance distance: Double, newAvgPace avgPace: UInt, newSpeed speed: Double, newTotalCal calories: Double)
    @objc optional func RunTrackerUpdate(newLocation location: CLLocation?)
}

enum RunningStatus {
    case notStart, started, paused, finished
}

class RunTracker: NSObject, CLLocationManagerDelegate {
    
    public static let shared: RunTracker = RunTracker()
    static let startedARunningNotification = "ARunHasStarted"
    static let finishedARunningNotification = "ARunHasFinished"
    
    var locationManager: CLLocationManager!
    weak var runTrackerDelegate: RunTrackerDelegate?
    var runningStatus: RunningStatus! {
        didSet {
            if runningStatus == RunningStatus.started {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: RunTracker.startedARunningNotification), object: nil)
                if self.locationManager != nil {
                    self.locationManager.allowsBackgroundLocationUpdates = true
                }
            }else if runningStatus == RunningStatus.paused {
                if self.locationManager != nil {
                    self.locationManager.allowsBackgroundLocationUpdates = false
                }
            } else if runningStatus == RunningStatus.finished {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: RunTracker.finishedARunningNotification), object: nil)
                if self.locationManager != nil {
                    self.locationManager.allowsBackgroundLocationUpdates = false
                }
            }
        }
    }
    
    var locations: [CLLocation]?
    var distanceSum: Double = 0.0 // in meters
    var caloriesSum: Double = 0.0 // in calories
    var timeSum: UInt32 = 0
    var startTime: Date?
    
    
    override init() {
        super.init()
        
        // Setup location manager
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.allowsBackgroundLocationUpdates = false
        
        // Setup variables
        self.runningStatus = RunningStatus.notStart
        self.locations = [CLLocation]()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            if self.runningStatus == RunningStatus.started {
                var tempLength: Double = 0.0
                // var hasValidLocation: Bool = false
                for alocation in locations {
                    if abs(alocation.speed) < 10.0 {
                        // update the record
                        let lastLocation = self.locations?.last
                        if lastLocation != nil {
                            tempLength += alocation.distance(from: lastLocation!)
                        }
                        self.locations?.append(alocation)
                    }
                    
                    /*
                    if alocation.horizontalAccuracy < 10 {
                        // update the record
                        let lastLocation = self.locations?.last
                        if lastLocation != nil {
                            tempLength += alocation.distance(from: lastLocation!)
                        }
                        self.locations?.append(alocation)
                        hasValidLocation = true
                    }*/
                }
                // if hasValidLocation {
                    self.distanceSum += tempLength
                    var avgPaceInSeconds: Double = 0.0
                    if self.distanceSum > 0 {
                        avgPaceInSeconds = (Double(self.timeSum) / self.distanceSum) * 1609.344
                    }
                    let lastSpeed: Double = abs((locations.last?.speed)!)
                    print("in RunTracker, \(lastSpeed)")
                    if lastSpeed.isInfinite || lastSpeed.isNaN {
                        
                        return
                    }
                    if lastSpeed < 1.3 { // walking
                        self.caloriesSum += 155.0 * 0.53 * tempLength / 1609.344
                    } else { // running
                        self.caloriesSum += 155.0 * 0.75 * tempLength / 1609.344
                    }
                    self.runTrackerDelegate?.RunTrackerUpdate?(newDistance: self.distanceSum, newAvgPace: UInt(avgPaceInSeconds), newSpeed: lastSpeed, newTotalCal: self.caloriesSum)
                // } else {
                //     print("in RunTracker, no valid location")
                // }
                
            } else if self.runningStatus == RunningStatus.notStart {
                self.runTrackerDelegate?.RunTrackerUpdate?(newLocation: locations.last)
            }
        }
    }
    
    
    func reset() {
        locations?.removeAll()
        distanceSum = 0.0
        caloriesSum = 0.0
        timeSum = 0
        startTime = Date()
    }
    
}
