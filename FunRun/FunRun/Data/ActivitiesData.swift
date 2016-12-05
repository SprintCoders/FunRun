//
//  TestData.swift
//  FunRun
//
//  Created by hideki on 11/27/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import Foundation

class ActivitiesData {
    // Date, Type, Route Name,Distance (mi),Duration,Average Pace,Average Speed (mph),Calories Burned,Climb (ft),Average Heart Rate (bpm),Notes,GPX File
    enum Column:Int {
        case date = 0, type, routeName, distance, duration, averagePace, averagSpeed, caloriesBurned, climb, averageHeartRate,notes,gpxFile
    }
    
    let filename = "cardioActivities.csv"
    var csv:CSwiftV!
    
    let formatter:DateFormatter!

    init() {
        if let path = Bundle.main.path(forResource: filename, ofType: nil) {
            do {
                let text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                csv = CSwiftV(with: text)
            } catch {
                print("Failed to read text from \(filename)")
            }
        } else {
            print("not found")
        }
        
        // date formatter
        formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    var count:Int {
        return csv.rows.count
    }
    
    func getActivity(index:Int) -> Activity {
       return getActivity(from: csv.rows[index])
    }
    
    func getActivity(from:[String]) -> Activity {
        let activity = Activity()
        activity.date = getDate(from:from)
        activity.type = from[Column.type.rawValue]
        activity.routeName = from[Column.routeName.rawValue]
        activity.distance = getDistance(from: from)
        activity.duration = getDuration(from: from)
        activity.avgPace = from[Column.averagePace.rawValue]
        activity.avgSpeed = getDouble(from:from, column:Column.averagSpeed)
        activity.caloriesBurned = getCaloriesBurned(from: from)
        activity.climb = getDouble(from:from, column:Column.climb)
        activity.avgHeartRate = from[Column.averageHeartRate.rawValue]
        activity.notes = from[Column.notes.rawValue]
        activity.gpxFile = from[Column.gpxFile.rawValue]
        return activity
    }
    
    func getDate(from: [String]) -> Date {
        return parse(strDate: from[Column.date.rawValue])
    }
    
    func getDouble(from:[String], column:Column) -> Double {
        return Double(from[column.rawValue])!
    }
    
    func getDistance(from: [String]) -> Double {
        return Double(from[Column.distance.rawValue])!
    }
    
    func getDuration(from: [String]) -> String {
        return from[Column.duration.rawValue]
    }
    
    func getCaloriesBurned(from: [String]) -> Double {
        return Double(from[Column.caloriesBurned.rawValue])!
    }
    
    func parse(strDate:String) -> Date {
        return formatter.date(from: strDate)!
    }
    
    // MARK: common
    var firstActivityDate:Date {
        return getDate(from: csv.rows.last!)
    }
    
    var lastActivityDate:Date {
        return getDate(from: csv.rows.first!)
    }
    
    // MARK: Hightlight
    
    // lifetime
    var totalCount:Int {
        return csv.rows.count
    }
    
    var totalDistance: Double {
        return total(column: .distance)
    }
    
    var totalCalories: Double {
        return total(column: .caloriesBurned)
    }
    var totalClimb: Double {
        return total(column: .climb)
    }
    private func total(column: Column) -> Double{
        var total:Double = 0.0
        for row in csv.rows {
            if let value = Double(row[column.rawValue]) {
                total += value
            }
        }
        return total
    }
    
    // current year
    var currentYearCount:Int {
        var count:Int = 0
        for row in csv.rows.reversed() {
            if getDate(from: row) >= Date.firstDayOfYear {
                count += 1
            }
        }
        return count
    }
    
    var currentYearDistance: Double {
        return totalCurrentYear(column: .distance)
    }
    
    var currentYearCalories: Double {
        return totalCurrentYear(column: .caloriesBurned)
    }
    
    var currentYearClimb: Double {
        return totalCurrentYear(column: .climb)
    }
    
    private func totalCurrentYear(column: Column) -> Double{
        var total:Double = 0.0
        for row in csv.rows {
            if getDate(from: row) >= Date.firstDayOfYear {
                if let value = Double(row[column.rawValue]) {
                    total += value
                }
            }else{
                break
            }
        }
        return total
    }

    // last 3 monthes
    var lastThreeMonthsCount:Int {
        var count:Int = 0
        for row in csv.rows.reversed() {
            if getDate(from: row) >= Date.threeMonthsAgo {
                count += 1
            }
        }
        return count
    }
    
    var lastThreeMonthsDistance: Double {
        return totalLastThreeMonths(column: .distance)
    }
    
    var lastThreeMonthsCalories: Double {
        return totalLastThreeMonths(column: .caloriesBurned)
    }
    
    var lastThreeMonthsClimb: Double {
        return totalLastThreeMonths(column: .climb)
    }
    
    private func totalLastThreeMonths(column: Column) -> Double{
        var total:Double = 0.0
        for row in csv.rows {
            if getDate(from: row) >= Date.threeMonthsAgo {
                if let value = Double(row[column.rawValue]) {
                    total += value
                }
            }else{
                break
            }
        }
        return total
    }
    // last 30 days
    var lastThirtyDaysCount:Int {
        var count:Int = 0
        for row in csv.rows.reversed() {
            if getDate(from: row) >= Date.monthAgo {
                count += 1
            }
        }
        return count
    }
    
    var lastThirtyDaysDistance: Double {
        return totalLastThirtyDays(column: .distance)
    }
    
    var lastThirtyDaysCalories: Double {
        return totalLastThirtyDays(column: .caloriesBurned)
    }
    
    var lastThirtyDaysClimb: Double {
        return totalLastThirtyDays(column: .climb)
    }
    
    private func totalLastThirtyDays(column: Column) -> Double{
        var total:Double = 0.0
        for row in csv.rows {
            if getDate(from: row) >= Date.monthAgo {
                if let value = Double(row[column.rawValue]) {
                    total += value
                }
            }else{
                break
            }
        }
        return total
    }
    
    // MARK: - Activities
    
    // 0 mi   -> 0
    // 2.5 mi -> 1
    // 5 mi   -> 2
    // 10mi   -> 3
    // 20mi   -> 4
    func distanceIndexArray() -> [Int] {
        let dict = distanceDict()
        var data:[Int] = []
        for delta in (-365...0).reversed(){
            let date = Calendar.current.date(byAdding: .day, value: delta, to: Date.today)?.day
            if let value = dict[date!] {
                data.append(value)
            }else{
                data.append(0)
            }
        }
        return data
    }
    func distanceDict() -> [Date:Int] {
        var data: [Date:Int] = [:]
        for row in csv.rows {
            let date = getDate(from: row)
            if date >= Date.yearAgo {
               data[date.day] = distance2Index(distance: getDistance(from: row))
            }else{
                break
            }
        }
        return data
    }
    func distance2Index(distance: Double) -> Int {
        switch distance {
        case 0.0:
            return 0
        case 0.0 ..< 2.5:
            return 1
        case 2.5 ..< 5.0:
            return 2
        case 5.0 ..< 10.0:
            return 3
        default:
            return 4
        }
    }
    
    
    // MARK: - Activities
    
    enum DataType:Int {
        case distance = 0, duration, caloriesBurned
    }
    
    func dataType2Column(type:DataType) -> Column {
        switch type{
        case .distance:
            return Column.distance
        case .duration:
            return Column.duration
        case .caloriesBurned:
            return Column.caloriesBurned
        }
    }
    
    // distance per day for last one year
    func dataPerDay(type: DataType) -> [(String, Double)] {
        var dict:[String:Double] = [:]
        let start = Date.today.threeMonthsAgo
        for i in stride(from: csv.rows.count - 1, to: 0, by: -1) {
            let row = csv.rows[i]
            let date = getDate(from: row)
            if date >= start {
                dict[date.strDay] = getDouble(from: row, column: dataType2Column(type: type))
            }
        }
        var array:[(String, Double)] = []
        var date = start
        while date < Date.today {
            let strDate = date.strDay
            if let value = dict[strDate] {
                array.append((strDate, value))
            }else{
                array.append((strDate, 0.0))
            }
            date = date.nextDay
        }
        return array
    }
    
    // data per week
    func dataPerWeek(type: DataType) -> [(String, Double)] {
        let array:[(String, Double)] = []
        return array
    }
    
    // data per month for last 12 monthes
    func dataPerMonth(type: DataType) -> [(String, Double)] {
        var valuePerMonth:[String:Double] = [:]
        for row in csv.rows {
            let date = getDate(from: row)
            let value = getDouble(from: row, column: dataType2Column(type: type))
            let mon = date.strYearAndMonth
            if let val = valuePerMonth[mon] {
                valuePerMonth[mon] = val + value
            }else{
                valuePerMonth[mon] = value
            }
        }
        
        var array:[(String, Double)] = []
        var date = Date.today
        for _ in 0..<12 {
            let mon = date.strYearAndMonth
            if let distance = valuePerMonth[mon] {
                array.append((mon, distance))
            }else{
                array.append((mon, 0.0))
            }
            date = date.monthAgo
        }
        return array.reversed()
    }

}
