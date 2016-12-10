//
//  ActivityListViewController.swift
//  FunRun
//
//  Created by DINGKaile on 12/8/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit
import CoreData

class ActivityListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var activityTable: UITableView!
    
    var recentActivities = [Activity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navigation Bar
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        
        // Setup tableView
        activityTable.dataSource = self
        activityTable.delegate = self
        activityTable.estimatedRowHeight = 50.0
        activityTable.rowHeight = UITableViewAutomaticDimension
        
        // Setup Data
        retrieveRunDataFromCoreData { 
            print("Successfully loaded data")
        }
        
        createFakeData()
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

    
    /* MARK: - TableView Delegate functions */
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return recentActivities.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityCell
        cell.activity = recentActivities[(recentActivities.count - indexPath.row)-1]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    /* MARK: - helper functions */
    func retrieveRunDataFromCoreData (completion block: (() -> Void)) {
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<RunActivity> = RunActivity.fetchRequest()
        
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchResults = try context.fetch(fetchRequest)
            print("Successfully retrieved a running data")
            
            self.recentActivities.removeAll()
            
            for runActivity in fetchResults as [NSManagedObject] {
                
                let startDate = runActivity.value(forKey: "startDay") as! Date
                let totalDistance = runActivity.value(forKey: "totalDistance") as! Double
                let totalDuration = runActivity.value(forKey: "totalDuration") as! UInt32
                let totalCalories = runActivity.value(forKey: "totalCalories") as! UInt32
                let bestSpeed = runActivity.value(forKey: "bestSpeed") as! Double
                let worstSpeed = runActivity.value(forKey: "worstSpeed") as! Double
                let notes = runActivity.value(forKey: "notes") as! String
                let avgPace = runActivity.value(forKey: "avgPace") as! String
                let runName = runActivity.value(forKey: "runName") as! String
                
                let oneActivity: Activity = Activity()
                oneActivity.date = startDate
                oneActivity.type = "By FunRun"
                oneActivity.routeName = runName
                oneActivity.distance = totalDistance/1609.344
                oneActivity.duration = TimeCount.convertIntToTime(seconds: totalDuration)
                oneActivity.avgPace = avgPace
                oneActivity.avgSpeed = (bestSpeed + worstSpeed)*0.5
                oneActivity.caloriesBurned = Double(totalCalories)
                oneActivity.climb = 0.0
                oneActivity.avgHeartRate = "didn't measure"
                oneActivity.notes = notes
                oneActivity.gpxFile = "unknown gpxFile"
                
                self.recentActivities.append(oneActivity)
                
                /*
                 let locationSetData = runActivity.value(forKey: "locationSet") as! Data
                 let locationSetJson = try JSONSerialization.jsonObject(with: locationSetData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: [Any]]
                 if let locationSet = locationSetJson["data"] {
                 for location in locationSet {
                 let locationJson = location as! [String: Any]
                 print("latitude is: \(locationJson["latitude"] as! Double)")
                 }
                 }
                 */
            }
            self.activityTable.reloadData()
        } catch {
            print("Error with request: \(error)")
        }
        block()
    }
    
    func createFakeData() {
        let oneActivity: Activity = Activity()
        oneActivity.date = Date()
        oneActivity.type = "By FunRun"
        oneActivity.routeName = "hehe"
        oneActivity.distance = 29.06
        oneActivity.duration = TimeCount.convertIntToTime(seconds: 1000)
        oneActivity.avgPace = "07:21"
        oneActivity.avgSpeed = 23.5
        oneActivity.caloriesBurned = 159.0
        oneActivity.climb = 0.0
        oneActivity.avgHeartRate = "didn't measure"
        oneActivity.notes = "fake notes"
        oneActivity.gpxFile = "unknown gpxFile"
        
        self.recentActivities.append(oneActivity)
        self.recentActivities.append(oneActivity)
        self.recentActivities.append(oneActivity)
        self.activityTable.reloadData()
    }
}
