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
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    func getDate(from: [String]) -> Date {
        return parse(strDate: from[Column.date.rawValue])
    }
    func getDistance(from: [String]) -> Double {
        return Double(from[Column.distance.rawValue])!
    }
    func parse(strDate:String) -> Date {
        return formatter.date(from: strDate)!
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
    func distancePerMonth() -> [[String: Double]] {
        var array:[[String: Double]] = []
        for row in csv.rows {
            let date = getDate(from: row)
            let distance = getDistance(from: row)
        }
        return array
    }
}
