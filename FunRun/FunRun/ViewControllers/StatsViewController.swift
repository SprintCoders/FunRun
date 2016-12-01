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
    @IBOutlet weak var activityScrollView: UIScrollView!

    // graphs
    @IBOutlet weak var distanceBarChartView: BarChartView!
    @IBOutlet weak var durationBarChartView: BarChartView!
    @IBOutlet weak var caloriesBarChartView: BarChartView!
    
    var months:[String]!
    
    // actions
    @IBAction func didTapGesture(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "chartSegue", sender: self.navigationController)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activityScrollView.scrollToRight(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // profile
        updateProfileView()
        
        // hightlight
        highlightTermSegment.selectedSegmentIndex = HightlightDuration.lifeTime.rawValue
        updateHighlightView(duration: HightlightDuration.lifeTime)
        
        // activities char
        activityChart.values = activities.distanceIndexArray()
        activityChart.updateUI()
        //activityScrollView.setContentOffset(<#T##contentOffset: CGPoint##CGPoint#>, animated: true)
        activityScrollView.scrollToRight(animated: true)
        
        
        // Do any additional setup after loading the view.
        
        distanceBarChartView.delegate = self
        durationBarChartView.delegate = self
        caloriesBarChartView.delegate = self
        
        months = ["Jan '16", "Feb '16","Mar '16","Apr '16","May '16","Jun '16","Jul '16","Aug '16","Sep '16","Oct '16","Nov '16","Dec '16"]
        let distancePerMonth = [84.4, 53.2, 50.2, 93.4, 127.4, 149.7, 188.0, 36.7, 89.6, 55.5, 0.0, 0.0]
        setChart(barChartView:distanceBarChartView, dataPoints: months, values: distancePerMonth, label:"Monthly distance (mile)")
        
        let durationPerMonth = [15.08, 10.58, 11.59, 20.11, 26.27, 28.47, 33.24, 5.52, 18.13, 11.56, 0.0, 0.0]
        setChart(barChartView:durationBarChartView, dataPoints: months, values: durationPerMonth, label:"Monthly duration (hour)")
        
        let caloriesPerMonth:[Double] = [9944, 5993, 5169, 10199, 14225, 17624, 22119, 4347, 9731, 5564, 0, 0]
        setChart(barChartView:caloriesBarChartView, dataPoints: months, values: caloriesPerMonth, label:"Monthly calories burned")
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
        barChartView.animate(xAxisDuration: 0.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
    }
    
    @IBAction func selectHighlightDuration(_ sender: UISegmentedControl) {
        updateHighlightView(duration: HightlightDuration(rawValue: sender.selectedSegmentIndex)!)
    }
}

extension StatsViewController : IAxisValueFormatter, ChartViewDelegate {
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value)]
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("\(entry.y) in \(entry.x)")
    }
}

