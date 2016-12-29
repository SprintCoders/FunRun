//
//  NewScheduleViewController.swift
//  FunRun
//
//  Created by Chenran Gong on 12/4/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit
import JTCalendar

class NewScheduleViewController: UIViewController, JTCalendarDelegate {
  
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var calendarMenuView: JTCalendarMenuView!
 
    @IBOutlet weak var calendarContentView: JTHorizontalCalendarView!
    
    let calendarManager = JTCalendarManager.init()
    var _dateSelected: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarManager.delegate = self
        calendarManager.menuView = calendarMenuView
        calendarManager.contentView = calendarContentView
        
        calendarManager.setDate(Date())
        
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.white.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @nonobjc func calendar(_ calendar: JTCalendarManager!, prepareDayView dayView: JTCalendarDayView!) {
        dayView.isHidden = false
//        if(dayView.isFromAnotherMonth){
//            dayView.isHidden = true
//        }
        // today
        if(calendarManager.dateHelper .date(Date(), isTheSameDayThan: dayView.date)){
            dayView.circleView.isHidden = false
            dayView.circleView.backgroundColor = UIColor.init(colorLiteralRed: 94/255, green: 161/255, blue: 120/255, alpha: 1)
            dayView.dotView.backgroundColor = UIColor.white
            dayView.textLabel.textColor = UIColor.white
        }
        //selected date
        else if((_dateSelected != nil) && calendarManager.dateHelper .date(_dateSelected, isTheSameDayThan: dayView.date)){
            dayView.circleView.isHidden = false
            dayView.circleView.backgroundColor = UIColor.red
            dayView.dotView.backgroundColor = UIColor.white
            dayView.textLabel.textColor = UIColor.white
        }
        // Other month
        else if(!calendarManager.dateHelper .date(calendarContentView.date, isTheSameMonthThan: dayView.date)){
            dayView.circleView.isHidden = true;
            dayView.dotView.backgroundColor = UIColor.red
            dayView.textLabel.textColor = UIColor.lightGray
        }
        else{
            dayView.circleView.isHidden = true
            dayView.dotView.backgroundColor = UIColor.red
            dayView.textLabel.textColor = UIColor.black
        }
    }
    
    @nonobjc func calendar(_ calendar: JTCalendarManager!, didTouchDayView dayView: JTCalendarDayView!) {
         _dateSelected = dayView.date
        
        dayView.circleView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.transition(with: dayView, duration: 3, options: UIViewAnimationOptions.curveEaseOut, animations: {() in
            dayView.circleView.transform = CGAffineTransform.identity
            self.calendarManager.reload()
        }, completion: nil)
        
        if(!calendarManager.dateHelper .date(calendarContentView.date, isTheSameMonthThan: dayView.date)){
            if(calendarContentView.date .compare(dayView.date) == .orderedAscending){
                calendarContentView.loadNextPageWithAnimation()
            }
            else{
                calendarContentView.loadPreviousPageWithAnimation()
            }
        }
    }

    @IBAction func startTimeOnEditing(_ sender: UITextField) {
        let startDatePickerView: UIDatePicker = UIDatePicker()
        startDatePickerView.datePickerMode = UIDatePickerMode.time
        sender.inputView = startDatePickerView
        startDatePickerView.addTarget(self, action: #selector(startTimePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func startTimePickerValueChanged(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "H:mm"
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeStyle = DateFormatter.Style.short
        startTimeTextField.text = dateFormatter.string(from: sender.date)
        
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func onSave(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
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
