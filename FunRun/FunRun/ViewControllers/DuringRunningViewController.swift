//
//  DuringRunningViewController.swift
//  FunRun
//
//  Created by DINGKaile on 11/26/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit
import MapKit

class DuringRunningViewController: UIViewController, RunTrackerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var chartsView: UIView!
    @IBOutlet weak var timeDistanceBarFrameView: UIView!
    
    
    @IBOutlet weak var simpleStatsView: UIView!
    @IBOutlet weak var speedLogCanvasView: UIView!
    
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    @IBOutlet weak var timeCountLabel: UILabel!
    @IBOutlet weak var avgPaceLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var distanceCountLabel: UILabel!
    @IBOutlet weak var distanceUnitLabel: UILabel!
    
    @IBOutlet weak var slidingContainerView: UIView!
    @IBOutlet weak var bgMapView: MKMapView!
    @IBOutlet weak var slidingContainerViewTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var slideupImageView: UIImageView!
    @IBOutlet weak var slideUpBarView: UIView!
    @IBOutlet weak var timeDistanceCountView: UIView!
    @IBOutlet weak var slideDownBarView: UIView!
    @IBOutlet weak var slidedownImageView: UIImageView!
    
    var slideDownPosCenter: CGPoint = CGPoint()
    var slideUpPosCenter: CGPoint = CGPoint()
    var slidedUp: Bool = false
    var trayOriginalCenter: CGPoint = CGPoint()
    var panGestureOriginalPoint: CGPoint = CGPoint()
    var velocityOfTray: CGPoint = CGPoint()
    
    var timer: DispatchTimer?
    
    var paused: Bool = false
    var accumulatedTime: UInt32 = 0 // in seconds
    var accumulatedDistance: Double = 0.0 // in meters
    var avgPace: String = "0:00:00" // "0:00:00"
    var currentSpeed: Double = 0.0
    var bestSpeed: Double = 0.0
    var worstSpeed: Double = DBL_MAX
    var calories: UInt32 = 0 // in calories
    let speedLogPath: UIBezierPath = UIBezierPath()
    var speedSet = [Double]()
    
    let themeGreen: UIColor = UIColor(displayP3Red: 0.435114, green: 0.684288, blue: 0.544333, alpha: 0.7)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // self.hidesBottomBarWhenPushed = true
        RunTracker.shared.runTrackerDelegate = self
        
        // Setup buttons
        self.pauseBtn.layer.cornerRadius = 15.0
        self.pauseBtn.clipsToBounds = true
        self.stopBtn.layer.cornerRadius = 15.0
        self.stopBtn.clipsToBounds = true
        self.pauseBtn.addTarget(self, action: #selector(pauseRunning), for: UIControlEvents.touchUpInside)
        // self.stopBtn.addTarget(self, action: #selector(stopRunning), for: UIControlEvents.touchUpInside)
        
        // Setup arrows
        self.slideupImageView.image = UIImage(named: "arrow_up")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.slideupImageView.tintColor = UIColor.lightGray
        self.slidedownImageView.image = UIImage(named: "arrow_down")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.slidedownImageView.tintColor = UIColor.lightGray
        self.slidedownImageView.alpha = 0.0
        
        // Setup mapView
        self.bgMapView.showsUserLocation = false
        self.bgMapView.delegate = self
        // self.bgMapView.setUserTrackingMode(MKUserTrackingMode.none, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let centerX = self.view.frame.width*0.5
        let slidingViewTopDownPosY = self.simpleStatsView.frame.origin.y - 82.0
        let slidingViewHeight = self.slidingContainerView.frame.height
        self.slideDownPosCenter = CGPoint(x: centerX, y: (slidingViewTopDownPosY + slidingViewHeight*0.5))
        let slidingViewTopUpPosY = self.chartsView.frame.origin.y - 10.0
        self.slideUpPosCenter = CGPoint(x: centerX, y: (slidingViewTopUpPosY + slidingViewHeight*0.5))
        self.slidingContainerView.center = self.slideDownPosCenter
        self.slidingContainerViewTopConstraint.constant = self.chartsView.frame.height - 82.0
        
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
        let paceHour: UInt = UInt(avgPace) / 3600
        let paceMin: UInt = (UInt(avgPace) % 3600) / 60
        let paceSec: UInt = UInt(avgPace) % 60
        self.avgPace = String(format: "%d:%d:%d", arguments: [paceHour, paceMin, paceSec])
        self.currentSpeed = speed
        self.speedSet.append(speed)
        if speed > self.bestSpeed {
            self.bestSpeed = speed
        }
        if speed < self.worstSpeed {
            self.worstSpeed = speed
        }
        self.calories = UInt32(calories)
        
        DispatchQueue.main.async {
            if distance/1609.344 < 0.01 {
                self.distanceCountLabel.text = String(format: "%.0f", arguments: [distance/0.3048])
                self.distanceUnitLabel.text = "feet"
            } else {
                self.distanceCountLabel.text = String(format: "%.2f", arguments: [distance/1609.344])
                self.distanceUnitLabel.text = "miles"
            }
            self.avgPaceLabel.text = self.avgPace
            self.caloriesLabel.text = "\(self.calories)"
            if !self.slidedUp {
                if (self.accumulatedTime & 0x3) == 0 {
                    self.drawSpeedGraph()
                }
            }
        }
 
    }
    
    
    /* MARK: - MapView Delegate function */
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if self.slidedUp {
            let span = MKCoordinateSpanMake(0.005, 0.005)
            let idealRegion = MKCoordinateRegion(center: userLocation.coordinate, span: span)
            // self.bgMapView.centerCoordinate = userLocation.coordinate
            let region = self.bgMapView.regionThatFits(idealRegion)
            self.bgMapView.setRegion(region, animated: true)
        }
    }
    
    /* MARK: - Button function */
    func pauseRunning() {
        if self.paused {
            print("-- pressed resume button")
            self.timer?.resume()
            self.pauseBtn.setTitle("Pause", for: UIControlState.normal)
            self.paused = false
            RunTracker.shared.runningStatus = RunningStatus.started
        } else {
            print("-- pressed pause button")
            self.timer?.suspend()
            self.pauseBtn.setTitle("Resume", for: UIControlState.normal)
            self.paused = true
            RunTracker.shared.runningStatus = RunningStatus.paused
        }
    }
    
    /*
    func stopRunning() {
        print("-- pressed stop button")
        self.performSegue(withIdentifier: "DuringToFinish", sender: self)
        
    }
    */
    
    
    /* MARK: - Gesture Recognizer functions */
    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
        // print("panned !!! \n")
        
        let point = sender.location(in: self.view)
        if sender.state == .began {
            self.trayOriginalCenter = self.slidingContainerView.center
            self.panGestureOriginalPoint = point
        } else if sender.state == .changed {
            self.velocityOfTray = sender.velocity(in: self.view)
            let transitionY = point.y - self.panGestureOriginalPoint.y
            self.slidingContainerView.center = CGPoint(x: self.trayOriginalCenter.x, y: (self.trayOriginalCenter.y + transitionY))
            let gradient = transitionY/(self.slideDownPosCenter.y - self.slideUpPosCenter.y)
            if self.slidedUp {
                self.timeDistanceCountView.alpha = 0.5 + 0.5*gradient
                self.simpleStatsView.alpha = 0.5 + 0.5*gradient
                self.slidedownImageView.alpha = 1.0 - gradient
                self.slidingContainerViewTopConstraint.constant = -10.0 + transitionY
            } else {
                self.timeDistanceCountView.alpha = 1.0 + 0.5*gradient
                self.simpleStatsView.alpha = 1.0 + 0.5*gradient
                self.slideupImageView.alpha = 1.0 + gradient
                self.slidingContainerViewTopConstraint.constant = (self.chartsView.frame.height - 82.0) + transitionY
            }
        } else if sender.state == .ended {
            if self.velocityOfTray.y < 0 {
                UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.slidingContainerView.center = self.slideUpPosCenter
                    self.slideupImageView.alpha = 0.0
                    self.slidedownImageView.alpha = 1.0
                    self.timeDistanceCountView.alpha = 0.5
                    self.simpleStatsView.alpha = 0.5
                    self.slidingContainerViewTopConstraint.constant = -10.0
                    self.bgMapView.showsUserLocation = true
                    self.slidedUp = true
                }, completion: nil)
            } else if self.velocityOfTray.y > 0 {
                UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.slidingContainerView.center = self.slideDownPosCenter
                    self.slideupImageView.alpha = 1.0
                    self.slidedownImageView.alpha = 0.0
                    self.timeDistanceCountView.alpha = 1.0
                    self.simpleStatsView.alpha = 1.0
                    self.slidingContainerViewTopConstraint.constant = self.chartsView.frame.height - 82.0
                    self.bgMapView.showsUserLocation = false
                    self.slidedUp = false
                }, completion: nil)
            }
        }
        
    }
    
    @IBAction func onTrayTapGesture(_ sender: UITapGestureRecognizer) {
        // print("tapped !!! \n")
        if self.slidedUp {
            UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.slidingContainerView.center = self.slideDownPosCenter
                self.slideupImageView.alpha = 1.0
                self.slidedownImageView.alpha = 0.0
                self.timeDistanceCountView.alpha = 1.0
                self.simpleStatsView.alpha = 1.0
                self.slidingContainerViewTopConstraint.constant = self.chartsView.frame.height - 82.0
                self.bgMapView.showsUserLocation = false
                self.slidedUp = false
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.slidingContainerView.center = CGPoint(x: self.slideDownPosCenter.x, y: self.slideDownPosCenter.y-15.0)
                self.slideupImageView.alpha = 0.0
                self.slidingContainerViewTopConstraint.constant = (self.chartsView.frame.height - 82.0) - 15.0
            }, completion: {(Bool) -> Void in
                UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.slidingContainerView.center = self.slideDownPosCenter
                    self.slideupImageView.alpha = 1.0
                    self.slidingContainerViewTopConstraint.constant = self.chartsView.frame.height - 82.0
                }, completion: nil)
            })
        }
    }
    
    
    
    /* MARK: - helper functions */
    func drawSpeedGraph() {
        if self.speedSet.count > 0 {
            let scopeWidth = Double(self.speedLogCanvasView.bounds.width)
            let scopeHeight = Double(self.speedLogCanvasView.bounds.height)
            let dx = scopeWidth/Double(self.speedSet.count)
            
            // let contextRecg = UIGraphicsGetCurrentContext()
            // contextRecg!.saveGState()
            self.speedLogPath.removeAllPoints()
            self.speedLogPath.move(to: CGPoint(x: 0.0, y: scopeHeight))
            var x = 0.0, y = scopeHeight
            for speed in self.speedSet {
                if self.bestSpeed > 0.0 {
                    y = scopeHeight - (scopeHeight * speed / self.bestSpeed)
                }
                x += dx
                self.speedLogPath.addLine(to: CGPoint(x: x, y: y))
            }
            self.speedLogPath.addLine(to: CGPoint(x: x, y: scopeHeight))
            self.speedLogPath.close()
            // contextRecg!.restoreGState()
            let shapeLayer: CAShapeLayer = CAShapeLayer()
            shapeLayer.path = self.speedLogPath.cgPath
            shapeLayer.backgroundColor = UIColor.clear.cgColor
            shapeLayer.fillColor = self.themeGreen.cgColor
            shapeLayer.strokeColor = self.themeGreen.cgColor
            shapeLayer.lineWidth = 1.0
            if self.speedLogCanvasView.layer.sublayers != nil {
                _ = self.speedLogCanvasView.layer.sublayers?.popLast()
            }
            self.speedLogCanvasView.layer.addSublayer(shapeLayer)
            
            // print("draw once -- -- \(self.bestSpeed)")
        }
    }
    
}
