//
//  ColorGradient.swift
//  FunRun
//
//  Created by DINGKaile on 12/4/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit

class ColorGradient: NSObject {
    
    // RGB for red (slowest)
    static let red_r = 1.0
    static let red_g = 51.0/255.0
    static let red_b = 51.0/255.0
    
    // RGB for yellow (middle)
    static let yellow_r = 1.0
    static let yellow_g = 153.0/255.0
    static let yellow_b = 51.0/255.0
    
    // RGB for blue (fastest)
    static let blue_r = 51.0/255.0
    static let blue_g = 153.0/255.0
    static let blue_b = 1.0
    
    class func colorBetweenRedAndYellow(ratio: Double) -> UIColor {
        let r = red_r + ratio * (yellow_r - red_r)
        let g = red_g + ratio * (yellow_g - red_g)
        let b = red_b + ratio * (yellow_b - red_b)
        return UIColor(colorLiteralRed: Float(r), green: Float(g), blue: Float(b), alpha: 1.0)
    }
    
    class func colorBetweenYellowAndBlue(ratio: Double) -> UIColor {
        let r = yellow_r + ratio * (blue_r - yellow_r)
        let g = yellow_g + ratio * (blue_g - yellow_g)
        let b = yellow_b + ratio * (blue_b - yellow_b)
        return UIColor(colorLiteralRed: Float(r), green: Float(g), blue: Float(b), alpha: 1.0)
    }

}
