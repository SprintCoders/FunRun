//
//  ChartViewController.swift
//  FunRun
//
//  Created by hideki on 11/24/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit
import Charts
class ChartViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    
    

    var months:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        barChartView.delegate = self
        
        months = ["Jan '16", "Feb '16","Mar '16","Apr '16","May '16","Jun '16","Jul '16","Aug '16","Sep '16","Oct '16","Nov '16","Dec '16"]
        let distancePerMonth = [84.4, 53.2, 50.2, 93.4, 127.4, 149.7, 188.0, 36.7, 89.6, 55.5, 0.0, 0.0]
        setChart(barChartView:barChartView, dataPoints: months, values: distancePerMonth, label:"Monthly distance (mile)")
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
}
extension ChartViewController : IAxisValueFormatter, ChartViewDelegate {
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value)]
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("\(entry.y) in \(entry.x)")
    }
}


