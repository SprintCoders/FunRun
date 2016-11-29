//
//  TabViewController.swift
//  FunRun
//
//  Created by DINGKaile on 11/14/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
    var statsNavCtr: UIViewController!
    var runningNavCtr: UIViewController!
    var activityNavCtr: UIViewController!
    var goalNavCtr: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.selectedIndex = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Stats
        let statsStoryBoard: UIStoryboard = UIStoryboard(name: "Stats", bundle: nil)
        statsNavCtr = statsStoryBoard.instantiateViewController(withIdentifier: "StatsNavigationController") as UIViewController
        statsNavCtr.tabBarItem.title = "Statistics"
        statsNavCtr.tabBarItem.image = UIImage(named: "statistics_tab")
        
        // Running
        let runningStoryBoard: UIStoryboard = UIStoryboard(name: "Running", bundle: nil)
        runningNavCtr = runningStoryBoard.instantiateViewController(withIdentifier: "RunningNavigationController") as UIViewController
        runningNavCtr.tabBarItem.title = "Running"
        runningNavCtr.tabBarItem.image = UIImage(named: "running_tab")
        
        // Activity
        let activityStoryBoard: UIStoryboard = UIStoryboard(name: "Activity", bundle: nil)
        activityNavCtr = activityStoryBoard.instantiateViewController(withIdentifier: "ActivityNavigationController") as UIViewController
        activityNavCtr.tabBarItem.title = "Activities"
        activityNavCtr.tabBarItem.image = UIImage(named: "activity_tab")
        
        // Goal
        let goalStoryBoard: UIStoryboard = UIStoryboard(name: "Goal", bundle: nil)
        goalNavCtr = goalStoryBoard.instantiateViewController(withIdentifier: "GoalNavigationController") as UIViewController
        goalNavCtr.tabBarItem.title = "Goal"
        goalNavCtr.tabBarItem.image = UIImage(named: "goal_tab")
        
        
        // add view controllers into viewControllers
        let controllers: [UIViewController]? = [statsNavCtr, runningNavCtr, activityNavCtr, goalNavCtr]
        self.viewControllers = controllers
        self.selectedIndex = 0
    }
}
