//
//  LocationTracker.swift
//  FunRun
//
//  Created by DINGKaile on 11/30/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import Foundation

class LocationTracker: NSObject {
    
    struct gpsLocation {
        var latitude: Double
        var longitude: Double
        var time: Date
        init(lat: Double, lon: Double) {
            latitude = lat
            longitude = lon
            time = Date()
        }
    }
    
    var locationArray: [gpsLocation]?
    
    override init() {
        super.init()
        locationArray = [gpsLocation]()
    }
    
    func appendNewLocation() {
        
    }
    
    
}
