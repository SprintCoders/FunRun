//
//  ViewController.swift
//  FunRunCode
//
//  Created by Chenran Gong on 11/19/16.
//  Copyright © 2016 Chenran Gong. All rights reserved.
//

import UIKit

class GoalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var scheduleTableView: UITableView!
    @IBOutlet weak var goalProgress: UIProgressView!
    //var schedules
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        
        goalProgress.transform = goalProgress.transform.scaledBy(x: 1, y: 5)
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
        goalProgress.setProgress(0, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateProgressView(){
        goalProgress.progress = 0.8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if (schedules != nil){
           // return schedules.count
        //}else{
            return 3
        //}
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleCell
        
        //cell.business = businesses[indexPath.row]
        
        return cell
    }
}

