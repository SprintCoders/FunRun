//
//  Activity.swift
//  FunRun
//
//  Created by hideki on 12/5/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import Foundation

class Activity {
    // Date, Type, Route Name,Distance (mi),Duration,Average Pace,Average Speed (mph),Calories Burned,Climb (ft),Average Heart Rate (bpm),Notes,GPX File
    // 2016-10-21 15:27:52,Running,,1.41,24:49,17:40,3.40,120.0,12.36,,,2016-10-21-1527.gpx
    
    var date:Date!
    var type:String!
    var routeName:String!
    var distance:Double!
    var duration:String!
    var avgPace:String!
    var avgSpeed:Double!
    var caloriesBurned:Double!
    var climb:Double!
    var avgHeartRate:String!
    var notes:String!
    var gpxFile:String!
}
