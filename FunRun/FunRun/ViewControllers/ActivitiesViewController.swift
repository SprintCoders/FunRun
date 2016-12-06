//
//  ActivitiesViewController.swift
//  FunRun
//
//  Created by hideki on 12/4/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit
import CoreData

class ActivitiesViewController: UIViewController {
    
    let activities = ActivitiesData()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    private func initTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.retrieveRunDataFromCoreData {
            print("done retrieving run data from core data")
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
    
    func retrieveRunDataFromCoreData (completion block: (() -> Void)) {
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<RunActivity> = RunActivity.fetchRequest()
        
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchResults = try context.fetch(fetchRequest)
            print("Successfully retrieved a running data")
            
            for runActivity in fetchResults as [NSManagedObject] {
                /*
                let startDate = runActivity.value(forKey: "startDay")
                let totalDistance = runActivity.value(forKey: "totalDistance")
                let totalDuration = runActivity.value(forKey: "totalDuration")
                let totalCalories = runActivity.value(forKey: "totalCalories")
                */
                let locationSetData = runActivity.value(forKey: "locationSet") as! Data
                let locationSetJson = try JSONSerialization.jsonObject(with: locationSetData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: [Any]]
                if let locationSet = locationSetJson["data"] {
                    for location in locationSet {
                        let locationJson = location as! [String: Any]
                        print("latitude is: \(locationJson["latitude"] as! Double)")
                    }
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
        block()
    }
    
}

extension ActivitiesViewController:  UITableViewDataSource, UITableViewDelegate {
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return activities.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityCell
        cell.activity = activities.getActivity(index:indexPath.row)
        return cell
    }

}
