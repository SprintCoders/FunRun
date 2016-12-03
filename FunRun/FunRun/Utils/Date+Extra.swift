//
//  Date+Extra.swift
//  FunRun
//
//  Created by hideki on 11/27/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import Foundation

extension Date {
    
    // return today (now)
    static var today: Date {
        return Date()
    }
    
    // return date of a month ago
    static var monthAgo: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: today)!
    }
    
    // return date of three months ago
    static var threeMonthsAgo:Date {
        return Calendar.current.date(byAdding: .month, value: -3, to: today)!
    }
    
    // return date of a year ago
    static var yearAgo:Date {
        return Calendar.current.date(byAdding: .year, value: -1, to: today)!
    }
    
    // return first date of year 01/01/yyyy 00:00:00
    static var firstDayOfYear:Date {
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: today)
        components.month = 1
        components.day = 1
        return Calendar.current.date(from: components)!
    }
    
    // return date with midnight MM/dd/yyyy 00:00:00
    var day: Date {
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: self)
        components.month = Calendar.current.component(.month, from: self)
        components.day = Calendar.current.component(.day, from: self)
        return Calendar.current.date(from: components)!
    }
}
