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
    
    // MARK:
    
    
    // return date with midnight MM/dd/yyyy 00:00:00
    var day: Date {
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: self)
        components.month = Calendar.current.component(.month, from: self)
        components.day = Calendar.current.component(.day, from: self)
        return Calendar.current.date(from: components)!
    }
    
    var prevDay: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var nextDay: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    // return date of a week ago
    var weekAgo: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: self)!
    }
    
    // return date of a month ago
    var monthAgo: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }
    var threeMonthsAgo: Date {
        return Calendar.current.date(byAdding: .month, value: -3, to: self)!
    }
    var yearAgo: Date {
        return Calendar.current.date(byAdding: .year, value: -1, to: self)!
    }
    // return year & month of today.
    var yearAndMonth:(Int, Int) {
        return (Calendar.current.component(.year, from: self),  // year
            Calendar.current.component(.month, from: self)) // month
    }
    var strYearAndMonth:String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM yyyy"
        return dateFormatterPrint.string(from: self)
    }
    
    var strDay:String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM/dd/yy"
        return dateFormatterPrint.string(from: self)
    }
    
    var strWeekDay:String{
        return Calendar.current.weekdaySymbols[Calendar.current.component(.weekday, from: self)-1]
    }
    
    // MARK: Methods
    func isDameDay(date:Date) -> Bool {
        return self.day == date.day
    }
    func since(date: Date) -> (days:Int, monthes:Int, years:Int) {
        let from = Calendar.current.startOfDay(for: date)
        let to = Calendar.current.startOfDay(for: self)
        let comps = Calendar.current.dateComponents([.day, .month, .year], from: from, to: to)
        return (comps.day!, comps.month!, comps.year!)
    }
}
