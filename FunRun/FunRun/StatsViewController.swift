//
//  StatsViewController.swift
//  FunRun
//
//  Created by hideki on 11/20/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit
import Charts

class StatsViewController: UIViewController {

    // profile
    @IBOutlet weak var profileImageView: UIImageView!
    
    // highlight

    @IBOutlet weak var dailyActivitiesView: UIView!
    
    // graphs
    
    @IBOutlet weak var distanceBarChartView: BarChartView!
    @IBOutlet weak var durationBarChartView: BarChartView!
    @IBOutlet weak var caloriesBarChartView: BarChartView!
    
    var months:[String]!
    var months2:[String]!
    
    // EAEAEA - gray
    // CDE56D - light green
    // 7ABF4D - green
    // 35972C - darker
    // 175817 - darkest
    let colors:[UIColor]! = [
        UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1), // EAEAEA - gray
        UIColor(red: 205/255, green: 229/255, blue: 106/255, alpha: 1), // CDE56D - light green
        UIColor(red: 122/255, green: 191/255, blue: 77/255,  alpha: 1), // 7ABF4D - green
        UIColor(red: 53/255,  green: 151/255, blue: 44/255,  alpha: 1), // 35972C - darker
        UIColor(red: 23/255,  green: 88/255,  blue: 23/255,  alpha: 1)] // 175817 - darkest
    
    // actions
    @IBAction func didTapGesture(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "chartSegue", sender: self.navigationController)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // profile
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.borderWidth = 1.0
        self.profileImageView.layer.borderColor = UIColor.white.cgColor
        self.profileImageView.layer.cornerRadius = 10.0
        
        
        // Do any additional setup after loading the view.
        
        distanceBarChartView.delegate = self
        durationBarChartView.delegate = self
        caloriesBarChartView.delegate = self
        
        months2 = ["Jan", "Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        
        months = ["Jan '16", "Feb '16","Mar '16","Apr '16","May '16","Jun '16","Jul '16","Aug '16","Sep '16","Oct '16","Nov '16","Dec '16"]
        let distancePerMonth = [84.4, 53.2, 50.2, 93.4, 127.4, 149.7, 188.0, 36.7, 89.6, 55.5, 0.0, 0.0]
        setChart(barChartView:distanceBarChartView, dataPoints: months, values: distancePerMonth, label:"Monthly distance (mile)")
        
        let durationPerMonth = [15.08, 10.58, 11.59, 20.11, 26.27, 28.47, 33.24, 5.52, 18.13, 11.56, 0.0, 0.0]
        setChart(barChartView:durationBarChartView, dataPoints: months, values: durationPerMonth, label:"Monthly duration (hour)")
        
        let caloriesPerMonth:[Double] = [9944, 5993, 5169, 10199, 14225, 17624, 22119, 4347, 9731, 5564, 0, 0]
        setChart(barChartView:caloriesBarChartView, dataPoints: months, values: caloriesPerMonth, label:"Monthly calories burned")
    
        
        /*
        // day of the week
        for row in 0...7{ // 7 days + month header
            let x = 0
            let y = row * 14
            let view = UIView(frame: CGRect(x: x, y: y, width: 30, height: 12))
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 26, height: 12))
            label.font = label.font.withSize(10)
            label.textAlignment = .right
            if row == 2 {
                label.text = "Mon"
            }else if row == 4 {
                label.text = "Wed"
            }else if row == 6 {
                label.text = "Fri"
            }
            view.addSubview(label)
            dailyActivitiesView.addSubview(view)
        }
        // month header
        for col in 0...11 { // 12 month
            let x = 30 + 14 * 4 * col
            let y = 0
            let label = UILabel(frame: CGRect(x: x, y: y, width: 14*4, height: 12))
            label.textAlignment = .center
            label.text = months2[col]
            label.font = label.font.withSize(10)
            dailyActivitiesView.addSubview(label)
            
        }
        // activities
        for col in 0...54 { // 52 + 2 weeks
            for row in 0...6{ // 7 days
                let x = 30 + col * 14
                let y = 14 + row * 14
                let view = UIView(frame: CGRect(x: x, y: y, width: 12, height: 12))
                view.backgroundColor = colors[row%5]
                dailyActivitiesView.addSubview(view)
            }
        }
         */
    }
    
    
    func setChart(barChartView:BarChartView!, dataPoints:[String], values:[Double], label:String!){
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count{
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: label)
        chartDataSet.colors = ChartColorTemplates.vordiplom()
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.xAxis.valueFormatter = self
        barChartView.chartDescription?.text = ""
        barChartView.xAxis.labelPosition = .bottom
        //barChartView.backgroundColor = UIColor(red: 189/255, green:195/255,blue:199/255,alpha: 1)
        barChartView.animate(xAxisDuration: 0.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        //let ll = ChartLimitLine(limit: 10.0, label: "Target")
        //barChartView.rightAxis.addLimitLine(ll)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension StatsViewController : IAxisValueFormatter, ChartViewDelegate {
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value)]
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("\(entry.y) in \(entry.x)")
    }
}

