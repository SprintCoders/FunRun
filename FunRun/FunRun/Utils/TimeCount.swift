//
//  TimeCount.swift
//  FunRun
//
//  Created by DINGKaile on 11/27/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import Foundation

class TimeCount: NSObject {
    
    class func convertIntToTime(seconds: UInt32) -> String {
        var res = ""
        /*
        if seconds/3600 > 0 {
            res += "\(seconds/3600):"
        }
        */
        res += "\(seconds/3600):"
        let lt1h = seconds%3600
        res += String(format: "%02d:", arguments: [lt1h/60])
        res += String(format: "%02d", arguments: [lt1h%60])
        // res += "\(lt1h/60):"
        // res += "\(lt1h%60)"
        
        return res
    }
}
