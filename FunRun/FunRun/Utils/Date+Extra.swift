//
//  Date+Extra.swift
//  FunRun
//
//  Created by hideki on 11/27/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import Foundation

extension Date {
    static var today: Date {
        return Date()
    }
    
    static var monthAgo: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: today)!
    }
    
    static var threeMonthsAgo:Date {
        return Calendar.current.date(byAdding: .month, value: -3, to: today)!
    }
    static var yearAgo:Date {
        return Calendar.current.date(byAdding: .year, value: -1, to: today)!
    }
    
    static var firstDayOfYear:Date {
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: today)
        components.month = 1
        components.day = 1
        return Calendar.current.date(from: components)!
    }
    
    
    
    
    var day: Date {
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: self)
        components.month = Calendar.current.component(.month, from: self)
        components.day = Calendar.current.component(.day, from: self)
        return Calendar.current.date(from: components)!
    }
}
