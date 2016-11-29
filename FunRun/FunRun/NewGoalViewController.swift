//
//  NewGoalViewController.swift
//  FunRunCode
//
//  Created by Chenran Gong on 11/27/16.
//  Copyright © 2016 Chenran Gong. All rights reserved.
//

import UIKit

class NewGoalViewController: UIViewController {

    @IBOutlet weak var startDate: UITextField!
    
    @IBOutlet weak var endDate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
        startDate.text = dateFormatter.string(from: sender.date)
        
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
        startDate.text = dateFormatter.string(from: sender.date)
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
