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
  
    @IBOutlet weak var calendarMenuView: JTCalendarMenuView!
 
    @IBOutlet weak var calendarContentView: JTHorizontalCalendarView!
    
    let calendarManager = JTCalendarManager.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarManager.delegate = self
        calendarManager.menuView = calendarMenuView
        calendarManager.contentView = calendarContentView
        
        calendarManager.setDate(Date())
        // Do any additional setup after loading the view.
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

}
