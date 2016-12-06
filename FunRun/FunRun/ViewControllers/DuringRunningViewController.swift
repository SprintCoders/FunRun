//
//  DuringRunningViewController.swift
//  FunRun
//
//  Created by DINGKaile on 11/26/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit

class DuringRunningViewController: UIViewController, RunTrackerDelegate {

    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var timeCountView: UIView!
    @IBOutlet weak var simpleStatsView: UIView!
    @IBOutlet weak var speedLogView: UIView!
    @IBOutlet weak var distanceCountView: UIView!
    @IBOutlet weak var distanceCountViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    @IBOutlet weak var timeCountLabel: UILabel!
    @IBOutlet weak var avgPaceLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var distanceCountLabel: UILabel!
    @IBOutlet weak var distanceUnitLabel: UILabel!
    
    
    var timer: DispatchTimer?
    
    var paused: Bool = false
    var accumulatedTime: UInt32 = 0 // in seconds
    var accumulatedDistance: Double = 0.0 // in meters
    var avgPace: String = "0:00:00" // "0:00:00"
    var currentSpeed: Double = 0.0
    var bestSpeed: Double = 0.0
    var worstSpeed: Double = DBL_MAX
    var calories: UInt32 = 0 // in calories
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // self.hidesBottomBarWhenPushed = true
        RunTracker.shared.runTrackerDelegate = self
        
        // Setup subview styles
        self.timeCountView.layer.borderWidth = 1.0
        self.simpleStatsView.layer.borderWidth = 1.0
        self.speedLogView.layer.borderWidth = 1.0
        self.distanceCountView.layer.borderWidth = 1.0
        
        // Setup buttons
        // self.pauseBtn.layer.borderWidth = 2.0
        self.pauseBtn.layer.cornerRadius = 10.0
        // let pauseBtnClr = self.pauseBtn.currentTitleColor
        // self.pauseBtn.layer.borderColor = pauseBtnClr.cgColor
        self.pauseBtn.clipsToBounds = true
        // self.stopBtn.layer.borderWidth = 2.0
        self.stopBtn.layer.cornerRadius = 10.0
        // let stopBtnClr = self.stopBtn.currentTitleColor
        // self.stopBtn.layer.borderColor = stopBtnClr.cgColor
        self.stopBtn.clipsToBounds = true
        self.pauseBtn.addTarget(self, action: #selector(pauseRunning), for: UIControlEvents.touchUpInside)
        // self.stopBtn.addTarget(self, action: #selector(stopRunning), for: UIControlEvents.touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
        if self.paused {
            self.tabBarController?.tabBar.isHidden = false
            //self.distanceCountViewBottomConstraint.constant = (tabBarController?.tabBar.frame.height)!
            
        } else {
            self.tabBarController?.tabBar.isHidden = true
        }
        */
        self.distanceCountViewBottomConstraint.constant = 0.0
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Setup timer
        if self.timer == nil {
            self.timer = DispatchTimer(repeatInterval: 1.0, block: { (DispatchTimer) in
                self.accumulatedTime += 1
                RunTracker.shared.timeSum = self.accumulatedTime
                self.timeCountLabel.text = TimeCount.convertIntToTime(seconds: self.accumulatedTime)
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /* MARK: - Navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "DuringToFinish" {
            let FinishRunningVC = segue.destination as! FinishRunningViewController
            FinishRunningVC.totalDistance = self.accumulatedDistance
            FinishRunningVC.totalTime = self.accumulatedTime
            FinishRunningVC.avgPace = self.avgPace
            FinishRunningVC.bestSpeed = self.bestSpeed
            FinishRunningVC.worstSpeed = self.worstSpeed
            FinishRunningVC.calories = self.calories
            self.timer?.cancel()
            self.timer = nil
            RunTracker.shared.runningStatus = RunningStatus.finished
        }
    }
    
    
    /* MARK: - RunTrackerDelegate functions */
    func RunTrackerUpdate(newDistance distance: Double, newAvgPace avgPace: UInt, newSpeed speed: Double, newTotalCal calories: Double) {
        self.accumulatedDistance = distance
        if distance/1609.344 < 0.01 {
            self.distanceCountLabel.text = String(format: "%.0f", arguments: [distance/0.3048])
            self.distanceUnitLabel.text = "feet"
        } else {
            self.distanceCountLabel.text = String(format: "%.2f", arguments: [distance/1609.344])
            self.distanceUnitLabel.text = "miles"
        }
        let paceHour: UInt = UInt(avgPace) / 3600
        let paceMin: UInt = (UInt(avgPace) % 3600) / 60
        let paceSec: UInt = UInt(avgPace) % 60
        self.avgPace = String(format: "%d:%d:%d", arguments: [paceHour, paceMin, paceSec])
        self.avgPaceLabel.text = self.avgPace.appending(" per mil")
        self.currentSpeed = speed
        if speed > self.bestSpeed {
            self.bestSpeed = speed
        }
        if speed < self.worstSpeed {
            self.worstSpeed = speed
        }
        self.calories = UInt32(calories)
        self.caloriesLabel.text = "\(self.calories) Cal"
    }
    
    
    /* MARK: - Button function */
    func pauseRunning() {
        if self.paused {
            print("-- pressed resume button")
            self.timer?.resume()
            self.pauseBtn.setTitle("PAUSE", for: UIControlState.normal)
            self.paused = false
            RunTracker.shared.runningStatus = RunningStatus.started
            // self.tabBarController?.tabBar.isHidden = true
            // self.distanceCountViewBottomConstraint.constant = 0.0
        } else {
            print("-- pressed pause button")
            self.timer?.suspend()
            self.pauseBtn.setTitle("RESUME", for: UIControlState.normal)
            self.paused = true
            RunTracker.shared.runningStatus = RunningStatus.paused
            // self.tabBarController?.tabBar.isHidden = false
            // self.distanceCountViewBottomConstraint.constant = (tabBarController?.tabBar.frame.height)!
        }
        // self.distanceCountViewBottomConstraint.constant = 0.0
        // self.view.layoutIfNeeded()
    }
    
    /*
    func stopRunning() {
        print("-- pressed stop button")
        self.performSegue(withIdentifier: "DuringToFinish", sender: self)
        
    }
    */
    
}
