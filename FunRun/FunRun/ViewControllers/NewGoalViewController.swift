//
//  NewGoalViewController.swift
//  FunRunCode
//
//  Created by Chenran Gong on 11/27/16.
//  Copyright © 2016 Chenran Gong. All rights reserved.
//

import UIKit

class NewGoalViewController: UIViewController {

    @IBOutlet weak var goalTypeTab: UISegmentedControl!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceTextfield: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var optionalLabel: UILabel!
    @IBOutlet weak var optionalTextField: UITextField!
    @IBOutlet weak var lbLabel: UILabel!
    @IBOutlet weak var lastLine: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        optionalLabel.isHidden = true
        optionalTextField.isHidden = true
        lbLabel.isHidden = true
        lastLine.isHidden = true
        
        self.goalTypeTab.layer.cornerRadius = 10.0
        self.goalTypeTab.layer.borderColor = UIColor.init(colorLiteralRed: 94.0/255.0, green: 161.0/255.0, blue: 120.0/255.0, alpha: 1).cgColor
        self.goalTypeTab.layer.borderWidth = 1.0
        self.goalTypeTab.layer.masksToBounds = true
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.white.cgColor
        
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
    }
    
    
    @IBAction func saveNewGoal(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func startDateOnEditing(_ sender: UITextField) {
        let startDatePickerView: UIDatePicker = UIDatePicker()
        startDatePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = startDatePickerView
        startDatePickerView.addTarget(self, action: #selector(startDatePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func startDatePickerValueChanged(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        startDateTextField.text = dateFormatter.string(from: sender.date)
        
    }
    
    @IBAction func endDateOnEditing(_ sender: UITextField) {
        let endDatePickerView: UIDatePicker = UIDatePicker()
        endDatePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = endDatePickerView
        endDatePickerView.addTarget(self, action: #selector(endDatePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func endDatePickerValueChanged(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        endDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        if(goalTypeTab.selectedSegmentIndex == 0){
            optionalLabel.isHidden = true
            optionalTextField.isHidden = true
            lbLabel.isHidden = true
            lastLine.isHidden = true
        }
        else if(goalTypeTab.selectedSegmentIndex == 1){
            optionalLabel.isHidden = false
            optionalTextField.isHidden = false
            lbLabel.isHidden = false
            lastLine.isHidden = false
        }
        else if(goalTypeTab.selectedSegmentIndex == 2){
            optionalLabel.isHidden = true
            optionalTextField.isHidden = true
            lbLabel.isHidden = true
            lastLine.isHidden = true
        }
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
