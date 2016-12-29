//
//  RouteOnMap.swift
//  FunRun
//
//  Created by DINGKaile on 12/5/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class RouteOnMap: NSObject {
    
    // RGB for red (slowest)
    static let redSpeedColor = UIColor(colorLiteralRed: 1.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    // RGB for yellow (middle)
    static let yellowSpeedColor = UIColor(colorLiteralRed: 1.0, green: 153.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    // RGB for blue (fastest)
    static let blueSpeedColor = UIColor(colorLiteralRed: 51.0/255.0, green: 153.0/255.0, blue: 1.0, alpha: 1.0)
    
    class func getMapRegion(forlocations locationSet: [CLLocation]) -> MKCoordinateRegion {
        var minLatitude: Double = (locationSet.first?.coordinate.latitude)!
        var minLongitude: Double = (locationSet.first?.coordinate.longitude)!
        var maxLatitude: Double = minLatitude
        var maxLongitude: Double = minLongitude
        for gpsXY in locationSet {
            if gpsXY.coordinate.latitude < minLatitude {
                minLatitude = gpsXY.coordinate.latitude
            }
            if gpsXY.coordinate.latitude > maxLatitude {
                maxLatitude = gpsXY.coordinate.latitude
            }
            if gpsXY.coordinate.longitude < minLongitude {
                minLongitude = gpsXY.coordinate.longitude
            }
            if gpsXY.coordinate.longitude > maxLongitude {
                maxLongitude = gpsXY.coordinate.longitude
            }
        }
        let center = CLLocationCoordinate2D(latitude: (minLatitude + maxLatitude)*0.5, longitude: (minLongitude + maxLongitude)*0.5)
        let centerSpan = MKCoordinateSpan(latitudeDelta: (maxLatitude - minLatitude)*1.2, longitudeDelta: (maxLongitude - minLongitude)*1.2)
        let fitRegion = MKCoordinateRegion(center: center, span: centerSpan)
        
        return fitRegion
    }
    
    class func getPolyline(forlocations locationSet: [CLLocation]) -> MKPolyline {
        var coords = [CLLocationCoordinate2D]()
        let numOfLocations = locationSet.count
        for location in locationSet {
            coords.append(location.coordinate)
        }
        return MKPolyline(coordinates: coords, count: numOfLocations)
    }
    
    class func getColoredPolyline(forlocations locationSet: [CLLocation], withBestSpeed bestSpeed: Double, withWorstSpeed worstSpeed: Double) -> [MulticolorPolylineSegment] {
        // let meanSpeed = (bestSpeed + worstSpeed) * 0.5
        let speedDiff = bestSpeed - worstSpeed
        let slowThreshold = worstSpeed + speedDiff*0.2
        let fastThreshold = worstSpeed + speedDiff*0.4
        var colorSegments = [MulticolorPolylineSegment]()
        for index in 1...(locationSet.count-1) {
            let firstLoc = locationSet[index-1]
            let secondLoc = locationSet[index]
            var color: UIColor?
            if secondLoc.speed < slowThreshold {
                color = redSpeedColor
            } else if secondLoc.speed < fastThreshold {
                color = yellowSpeedColor
            } else {
                color = blueSpeedColor
            }
            /*
            if secondLoc.speed < meanSpeed {
                let ratio = (secondLoc.speed - worstSpeed) / (meanSpeed - worstSpeed)
                color = ColorGradient.colorBetweenRedAndYellow(ratio: ratio)
            } else {
                let ratio = (secondLoc.speed - meanSpeed) / (bestSpeed - meanSpeed)
                color = ColorGradient.colorBetweenYellowAndBlue(ratio: ratio)
            }
            */
            let colorSegment = MulticolorPolylineSegment(coordinates: [firstLoc.coordinate, secondLoc.coordinate], count: 2)
            colorSegment.color = color
            colorSegments.append(colorSegment)
        }
        return colorSegments
    }
    
}
