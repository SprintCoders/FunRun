//
//  TabViewController.swift
//  FunRun
//
//  Created by DINGKaile on 11/14/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {
    
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
        runningNavCtr.tabBarItem.title = "Run"
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
        self.delegate = self
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: RunTracker.startedARunningNotification), object: nil, queue: OperationQueue.main) { (notification) -> Void in
            // self.runningNavCtr.tabBarItem.image = UIImage(named: "running_tab2")
            self.runningNavCtr.tabBarItem = UITabBarItem(title: "Running", image: UIImage(named: "running_tab2")!, tag: 1)
            self.setNeedsStatusBarAppearanceUpdate()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: RunTracker.finishedARunningNotification), object: nil, queue: OperationQueue.main) { (notification) -> Void in
            // self.runningNavCtr.tabBarItem.image = UIImage(named: "running_tab")
            self.runningNavCtr.tabBarItem = UITabBarItem(title: "Run", image: UIImage(named: "running_tab")!, tag: 1)
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
    }
    
    
    
    /* MARK: - UITabBarControllerDelegate functions */
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch self.selectedIndex {
        case 0:
            return viewController != self.statsNavCtr
        case 1:
            return viewController != self.runningNavCtr
        case 2:
            return viewController != self.activityNavCtr
        case 3:
            return viewController != self.goalNavCtr
        default:
            return true
        }
    }
    
}
