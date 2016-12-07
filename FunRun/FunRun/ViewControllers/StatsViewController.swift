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

    enum HightlightDuration:Int {
        case lastThirtyDays = 0, lastThreeMonth, currentYear, lifeTime
    }
    
    enum GraphType:Int {
        case distance = 0, duration, caloriesBurned
    }
    
    enum GraphDuration:Int {
        case daily = 0, weekly, monthly
    }
    
    // data
    var profile = Profile()
    var activities = ActivitiesData()
    
    // profile
    @IBOutlet weak var highlightTermSegment: UISegmentedControl!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileMotivation: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    // highlight
    @IBOutlet weak var totalActivities: UILabel!
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var totalCalories: UILabel!
    @IBOutlet weak var totalClimb: UILabel!
    
    // activities
    @IBOutlet weak var activityChart: ActivityChartView!
    
    // graphs
    @IBOutlet weak var distanceBarChartView: BarChartView!
    @IBOutlet weak var durationBarChartView: BarChartView!
    @IBOutlet weak var caloriesBarChartView: BarChartView!

    
    // actions
    @IBAction func didTapGesture(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "chartSegue", sender: self.navigationController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // profile
        updateProfileView()
        
        // hightlight
        highlightTermSegment.selectedSegmentIndex = HightlightDuration.lifeTime.rawValue
        updateHighlightView(duration: HightlightDuration.lifeTime)
        
        // activities chart
        activityChart.values = activities.distanceIndexArray()
        activityChart.updateUI()
        
        // distance chart
        updateBarChart(barChartView: distanceBarChartView, graphType:.distance, duration: .daily)

        // curation chart
        let months = ["Jan '16", "Feb '16","Mar '16","Apr '16","May '16","Jun '16","Jul '16","Aug '16","Sep '16","Oct '16","Nov '16","Dec '16"]
        let durationPerMonth = [15.08, 10.58, 11.59, 20.11, 26.27, 28.47, 33.24, 5.52, 18.13, 11.56, 0.0, 0.0]
        //setChart(barChartView:durationBarChartView, dataPoints: months, values: durationPerMonth, label:"Monthly duration (hour)")
        //updateBarChart(barChartView: durationBarChartView, graphType:.duration, duration: .daily)
        updateChart(barChartView:durationBarChartView, dataPoints: months, values: durationPerMonth, label:"Monthly duration (hour)")
        
        // calories burned chart
        updateBarChart(barChartView: caloriesBarChartView, graphType:.caloriesBurned, duration: .daily)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.barTintColor = UIColor.init(colorLiteralRed: 94/255, green: 161/255, blue: 120/255, alpha: 1)
        nav?.tintColor = UIColor.white
    }
    
    private func updateProfileView(){
        // name
        profileName.text = profile.name
        // motivation
        profileMotivation.text = profile.motivation
        // image
        profileImageView.image = UIImage.init(named: profile.image)
        profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = 10.0
    }
    
    private func updateHighlightView(duration:HightlightDuration){
        switch duration {
        case .lifeTime:
            totalActivities.text = String(format: "%d", activities.totalCount)
            totalDistance.text = String(format: "%.0f mi", activities.totalDistance)
            totalCalories.text = String(format: "%.0f", activities.totalCalories)
            totalClimb.text = String(format: "%.0f ft", activities.totalClimb)
            break
        case .currentYear:
            totalActivities.text = String(format: "%d", activities.currentYearCount)
            totalDistance.text = String(format: "%.0f mi", activities.currentYearDistance)
            totalCalories.text = String(format: "%.0f", activities.currentYearCalories)
            totalClimb.text = String(format: "%.0f ft", activities.currentYearClimb)
            break
        case .lastThreeMonth:
            totalActivities.text = String(format: "%d", activities.lastThreeMonthsCount)
            totalDistance.text = String(format: "%.0f mi", activities.lastThreeMonthsDistance)
            totalCalories.text = String(format: "%.0f", activities.lastThreeMonthsCalories)
            totalClimb.text = String(format: "%.0f ft", activities.lastThreeMonthsClimb)
            break
        case .lastThirtyDays:
            totalActivities.text = String(format: "%d", activities.lastThirtyDaysCount)
            totalDistance.text = String(format: "%.0f mi", activities.lastThirtyDaysDistance)
            totalCalories.text = String(format: "%.0f", activities.lastThirtyDaysCalories)
            totalClimb.text = String(format: "%.0f ft", activities.lastThirtyDaysClimb)
            break
        }
    }
    
    @IBAction func selectHighlightDuration(_ sender: UISegmentedControl) {
        updateHighlightView(duration: HightlightDuration(rawValue: sender.selectedSegmentIndex)!)
    }
    
    @IBAction func selectDistanceDuration(_ sender: UISegmentedControl) {
        updateBarChart(barChartView:distanceBarChartView, graphType:.distance, duration: GraphDuration(rawValue: sender.selectedSegmentIndex)!)
    }
    @IBAction func selectDurationDuration(_ sender: UISegmentedControl) {
        updateBarChart(barChartView: durationBarChartView, graphType:.duration, duration: GraphDuration(rawValue: sender.selectedSegmentIndex)!)
    }
    @IBAction func selectCaloriesBurnedDuration(_ sender: UISegmentedControl) {
        updateBarChart(barChartView: caloriesBarChartView, graphType:.caloriesBurned, duration: GraphDuration(rawValue: sender.selectedSegmentIndex)!)
    }
    
    func updateBarChart(barChartView:BarChartView!, graphType: GraphType, duration: GraphDuration){
        var data: [(String, Double)]!
        var label:String!
        switch graphType{
        case .distance:
            switch duration {
            case .daily:
                label = "Last 3 months daily running distance (mile)"
                data = activities.dataPerDay(type: .distance)
                break
            case .weekly:
                label = "Weekly running distance (mile)"
                data = activities.dataPerWeek(type: .distance)
                break
            case .monthly:
                label = "Last 1 year Monthly running distance (mile)"
                data = activities.dataPerMonth(type: .distance)
                break
            }
            break
        case .duration:
            switch duration {
            case .daily:
                label = "Last 3 months daily running duration (hour)"
                data = activities.dataPerDay(type: .duration)
                break
            case .weekly:
                label = "Weekly running duration (hour)"
                data = activities.dataPerWeek(type: .duration)
                break
            case .monthly:
                label = "Last 1 year Monthly running duration (hour)"
                data = activities.dataPerMonth(type: .duration)
                break
            }
            break
        case .caloriesBurned:
            switch duration {
            case .daily:
                label = "Last 3 months daily calories burned by running"
                data = activities.dataPerDay(type: .caloriesBurned)
                break
            case .weekly:
                label = "Weekly  calories burned by running"
                data = activities.dataPerWeek(type: .caloriesBurned)
                break
            case .monthly:
                label = "Last 1 year Monthly  calories burned by running"
                data = activities.dataPerMonth(type: .caloriesBurned)
                break
            }
            break
        }
        
        var dataPoints:[String] = []
        var values:[Double] = []
        for distance in data {
            dataPoints.append(distance.0)
            values.append(distance.1)
        }
        updateChart(barChartView:barChartView, dataPoints: dataPoints, values: values, label:label)
    }
    
    func updateChart(barChartView:BarChartView!, dataPoints:[String], values:[Double], label:String!){
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count{
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: label)
        
        chartDataSet.colors = [UIColor(red: 118.0/255, green: 204.0/255, blue: 57.0/255, alpha: 1.0)]
        let chartData = BarChartData(dataSet: chartDataSet)
        for set in chartData.dataSets {
            set.drawValuesEnabled = false
        }
        barChartView.xAxis.valueFormatter = AxisValueFormatterImpl(labels: dataPoints)
        barChartView.data = chartData
        
        barChartView.chartDescription?.text = ""
        barChartView.xAxis.labelPosition = .bottom
        barChartView.animate(xAxisDuration: 0.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
    }
}


class AxisValueFormatterImpl : NSObject, IAxisValueFormatter {
    var labels:[String]
    
    init(labels:[String]) {
        self.labels = labels
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return labels[Int(value)]
    }
}

