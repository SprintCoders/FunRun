//
//  FinishRunningViewController.swift
//  FunRun
//
//  Created by DINGKaile on 11/26/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FinishRunningViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var runDayLabel: UILabel!
    
    @IBOutlet weak var distanceViewbox: UIView!
    @IBOutlet weak var durationViewBox: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var avgPaceViewBox: UIView!
    @IBOutlet weak var bestSpeedViewBox: UIView!
    @IBOutlet weak var CaloriesViewBox: UIView!
    @IBOutlet weak var avgPaceLabel: UILabel!
    @IBOutlet weak var bestSpeedLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var face1: UIImageView!
    @IBOutlet weak var face2: UIImageView!
    @IBOutlet weak var face3: UIImageView!
    @IBOutlet weak var face4: UIImageView!
    @IBOutlet weak var face5: UIImageView!
    
    @IBOutlet weak var noteField: UITextView!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var totalTime: UInt32 = 0
    var totalDistance: Double = 0.0
    var chosenFace: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.distanceViewbox.layer.borderWidth = 1.0
        self.distanceViewbox.layer.borderColor = UIColor.black.cgColor
        self.durationViewBox.layer.borderWidth = 1.0
        self.durationViewBox.layer.borderColor = UIColor.black.cgColor
        
        // Setup Emoji face images
        let tapFace1 = UITapGestureRecognizer(target: self, action: #selector(tapEmojiFace(gesture:)))
        self.face1.addGestureRecognizer(tapFace1)
        self.face1.tag = 1
        let tapFace2 = UITapGestureRecognizer(target: self, action: #selector(tapEmojiFace(gesture:)))
        self.face2.addGestureRecognizer(tapFace2)
        self.face2.tag = 2
        let tapFace3 = UITapGestureRecognizer(target: self, action: #selector(tapEmojiFace(gesture:)))
        self.face3.addGestureRecognizer(tapFace3)
        self.face3.tag = 3
        let tapFace4 = UITapGestureRecognizer(target: self, action: #selector(tapEmojiFace(gesture:)))
        self.face4.addGestureRecognizer(tapFace4)
        self.face4.tag = 4
        let tapFace5 = UITapGestureRecognizer(target: self, action: #selector(tapEmojiFace(gesture:)))
        self.face5.addGestureRecognizer(tapFace5)
        self.face5.tag = 5
        
        // Setup detail view boxes
        self.avgPaceViewBox.layer.borderWidth = 1.0
        self.avgPaceViewBox.layer.borderColor = UIColor.black.cgColor
        self.bestSpeedViewBox.layer.borderWidth = 1.0
        self.bestSpeedViewBox.layer.borderColor = UIColor.black.cgColor
        self.CaloriesViewBox.layer.borderWidth = 1.0
        self.CaloriesViewBox.layer.borderColor = UIColor.black.cgColor
        
        // Setup textView
        self.noteField.layer.borderWidth = 2.0
        self.noteField.layer.borderColor = UIColor.lightGray.cgColor
        self.noteField.layer.cornerRadius = 2.0
        self.noteField.clipsToBounds = true
        
        // Setup buttons
        self.saveBtn.layer.borderWidth = 2.0
        self.saveBtn.layer.cornerRadius = 5.0
        self.saveBtn.clipsToBounds = true
        let saveBtnClr = self.saveBtn.currentTitleColor
        self.saveBtn.layer.borderColor = saveBtnClr.cgColor
        self.saveBtn.addTarget(self, action: #selector(saveButtonPressed), for: UIControlEvents.touchUpInside)
        self.deleteBtn.layer.borderWidth = 2.0
        self.deleteBtn.layer.cornerRadius = 5.0
        self.deleteBtn.clipsToBounds = true
        let deleteBtnClr = self.deleteBtn.currentTitleColor
        self.deleteBtn.layer.borderColor = deleteBtnClr.cgColor
        self.deleteBtn.addTarget(self, action: #selector(deleteButtonPressed), for: UIControlEvents.touchUpInside)
        
        // Setup variables
        self.chosenFace = nil
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        self.runDayLabel.text = dateFormatter.string(from: Date()).appending(" Run")
        // let today = Calendar.current.component(.weekday, from: Date())
        // self.runDayLabel.text = ""
        self.durationLabel.text = TimeCount.convertIntToTime(seconds: self.totalTime)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    /* MARK: - helper functions */
    func tapEmojiFace(gesture: UITapGestureRecognizer) {
        let faceImgView = gesture.view as! UIImageView
        if self.chosenFace != nil {
            self.chosenFace!.alpha = 0.3
        }
        faceImgView.alpha = 1.0
        self.chosenFace = faceImgView
    }
    
    func saveButtonPressed() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func deleteButtonPressed() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }

}
