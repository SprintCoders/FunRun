//
//  ActivityChartView.swift
//  FunRun
//
//  Created by hideki on 11/26/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit

class ActivityChartView: UIView {
    
    var values:[Int]? = nil
    
    
    static let colors:[UIColor]! = [
        UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1), // EAEAEA - gray
        UIColor(red: 205/255, green: 229/255, blue: 106/255, alpha: 1), // CDE56D - light green
        UIColor(red: 122/255, green: 191/255, blue: 77/255,  alpha: 1), // 7ABF4D - green
        UIColor(red: 53/255,  green: 151/255, blue: 44/255,  alpha: 1), // 35972C - darker
        UIColor(red: 23/255,  green: 88/255,  blue: 23/255,  alpha: 1)] // 175817 - darkest
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //overide func view
    
    func updateUI(){
        // remove all sub views
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        let cal = Calendar.current
        
        // day of the week
        for row in 1...7{ // 7 days + month header
            let x = 0
            let y = row * 14
            let label = UILabel(frame: CGRect(x: x, y: y, width: 26, height: 12))
            label.font = label.font.withSize(10)
            label.textAlignment = .right
            if row % 2 == 0  {
                label.text = cal.shortWeekdaySymbols[row - 1]
            }
            self.addSubview(label)
        }
        
        // activities
        let baseView = UIView(frame: CGRect(x: 0, y: 0, width: 800, height: 14 * 8))
        //baseView.backgroundColor = UIColor.orange
        var week: Int = 0 // week
        for delta in -365...0{ // from a year ago to today
            let date:Date! = cal.date(byAdding: .day, value: delta, to: Date())
            let day: Int = cal.component(.weekday, from: date) // day
            if day == 1 && delta != -365 {
                week += 1
            }
            let x = week * 14
            let y = day * 14
            let view = UIView(frame: CGRect(x: x, y: y, width: 12, height: 12))
            if values != nil {
                view.backgroundColor = ActivityChartView.colors[(values?[abs(delta)])!]
            }else{
                view.backgroundColor = ActivityChartView.colors[0]
            }
            baseView.addSubview(view)
            
            // if 1st day of month, display month label
            if cal.component(.day, from: date) == 1 {
                let month: Int = cal.component(.month, from: date)
                let y = 0
                let label = UILabel(frame: CGRect(x: x, y: y, width: 14*4, height: 12))
                label.textAlignment = .left
                label.text = cal.shortMonthSymbols[month-1]
                label.font = label.font.withSize(10)
                baseView.addSubview(label)
            }
        }
        // adujst baseView size
        var newFrame = baseView.frame;
        newFrame.size.width = CGFloat((week + 1) * 14);
        baseView.frame = newFrame
        print("")
        
        // scroll view
        let scrollView = UIScrollView()
        scrollView.addSubview(baseView)
        scrollView.contentSize = baseView.bounds.size
        self.addSubview(scrollView)
        scrollView.frame = CGRect(x: 30, y: 0, width: self.frame.width - 30, height: 14 * 8)
        
        scrollView.scrollToRight(animated: true)
    }
}
