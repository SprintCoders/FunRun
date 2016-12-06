//
//  ViewController.swift
//  FunRunCode
//
//  Created by Chenran Gong on 11/19/16.
//  Copyright © 2016 Chenran Gong. All rights reserved.
//

import UIKit
import Charts

class GoalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var scheduleTableView: UITableView!
    
    @IBOutlet weak var newGoalButton: UIButton!
    @IBOutlet weak var goalPieChart: PieChartView!
    
    @IBOutlet weak var newScheduleButton: UIButton!
    
    @IBOutlet weak var GoalProgressLabel: UILabel!
    
    var schedule1: [String:String] = ["time": "Dec 11 2016 8:00 AM", "distance": "5 miles"]
    var schedule2: [String:String] = ["time": "Dec 12 2016 8:00 AM", "distance": "8 miles"]
    var schedule3: [String:String] = ["time": "Dec 13 2016 8:00 AM", "distance": "10 miles"]
    var schedules = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        schedules.append(schedule1)
        schedules.append(schedule2)
        schedules.append(schedule3)
        
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleTableView.tableFooterView = UIView()
        
        self.newGoalButton.layer.borderWidth = 5.0
        self.newGoalButton.layer.borderColor = self.newGoalButton.currentTitleColor.cgColor
        self.newGoalButton.layer.cornerRadius = 5.0
        self.newGoalButton.clipsToBounds = true
        
        self.newScheduleButton.layer.borderWidth = 5.0
        self.newScheduleButton.layer.borderColor = self.newScheduleButton.currentTitleColor.cgColor
        self.newScheduleButton.layer.cornerRadius = 5.0
        self.newScheduleButton.clipsToBounds = true
        
        let goalDistance = 13.0
        let finishedDistance = 5.0
        let goalTime = 140.0
        let finishedTime = 60.0
        
        let finishedGoal = (min(1.0, finishedDistance/goalDistance) * 0.5) + (min(1.0, finishedTime/goalTime) * 0.5)
        let finishedGoalInt = Int(finishedGoal*100)
        GoalProgressLabel.text = "Goal Finished \(finishedGoalInt)%"
        
        let progressArray = [finishedGoal, 1.0 - finishedGoal]
        let progressString = "Finished \(finishedGoal)"
        let progressStringArray = [progressString, ""]
        
        //let colors = [UIColor.blue, UIColor.init(red: 1, green: 0.5, blue: 0.5, alpha: 1)]
        //let colors = [UIColor(red: 249/255.0, green: 191/255.0, blue: 59/255.0, alpha: 1.0), UIColor.white]
        let colors = ChartColorTemplates.vordiplom()
        
        setChart(dataPoints: progressStringArray, values: progressArray, colors: colors)
        goalPieChart.animate(xAxisDuration: 3)
        
        newGoalButton.layer.cornerRadius = 10
        newGoalButton.layer.borderWidth = 1
        newGoalButton.layer.borderColor = UIColor.white.cgColor
        
        newScheduleButton.layer.cornerRadius = 10
        newScheduleButton.layer.borderWidth = 1
        newScheduleButton.layer.borderColor = UIColor.white.cgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for parent in navigationController!.view.subviews {
            for child in parent.subviews {
                for view in child.subviews {
                    if view is UIImageView && view.frame.height == 0.5 {
                        view.alpha = 0
                    }
                }
            }
        }
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.barTintColor = UIColor.init(colorLiteralRed: 94/255, green: 161/255, blue: 120/255, alpha: 1)
        nav?.tintColor = UIColor.white
    }
    
    
    func setChart(dataPoints: [String], values: [Double], colors: [UIColor]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            //let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Progress")
        pieChartDataSet.drawValuesEnabled = false
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        goalPieChart.maxAngle = 180.0
        goalPieChart.data = pieChartData
        
        
        pieChartDataSet.colors = colors
        goalPieChart.rotationAngle = 180.0
        goalPieChart.chartDescription = nil
        goalPieChart.rotationEnabled = false
        goalPieChart.legend.enabled = false;
        goalPieChart.highlightPerTapEnabled = false
        //goalPieChart.drawHoleEnabled = false
        goalPieChart.holeColor = UIColor.clear
        goalPieChart.transparentCircleColor = UIColor.clear
       // goalPieChart.drawEntryLabelsEnabled = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (schedules != nil){
           return schedules.count
        }else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleCell
        
        cell.timeLabel.text = schedules[indexPath.row]["time"]
        cell.distanceLabel.text = schedules[indexPath.row]["distance"]
        
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        if segue.identifier == "newGoal" {
//            let nav = segue.destination as! UINavigationController
//            let newGoalVC = nav.topViewController as! NewGoalViewController
//        }
//        if segue.identifier == "newSchedule" {
//            
//        }
//    }
    
}

