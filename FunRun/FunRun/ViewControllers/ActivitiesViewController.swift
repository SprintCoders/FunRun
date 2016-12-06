//
//  ActivitiesViewController.swift
//  FunRun
//
//  Created by hideki on 12/4/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
