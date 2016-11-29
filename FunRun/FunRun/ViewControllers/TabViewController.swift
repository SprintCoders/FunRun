//
//  TabViewController.swift
//  FunRun
//
//  Created by DINGKaile on 11/14/16.
//  Copyright © 2016 SprintCoders. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Stats
        let statsStoryBoard: UIStoryboard = UIStoryboard(name: "Stats", bundle: nil)
        let statsViewController:UIViewController = statsStoryBoard.instantiateViewController(withIdentifier: "StatsNavigationController") as UIViewController
        statsViewController.tabBarItem.title = "Statistics"
        statsViewController.tabBarItem.image = UIImage(named: "statistics_tab")
        
        // Goal
        let goalStoryBoard: UIStoryboard = UIStoryboard(name: "Goal", bundle: nil)
        let goalViewController:UIViewController = goalStoryBoard.instantiateViewController(withIdentifier: "GoalNavigationController") as UIViewController
        goalViewController.tabBarItem.title = "Goal"
        goalViewController.tabBarItem.image = UIImage(named: "goal_tab")
        
        
        // add view controllers into viewControllers
        var controllers = self.viewControllers
        controllers?.insert(statsViewController, at: 0)
        controllers?.insert(goalViewController, at: 3)
        self.viewControllers = controllers
        
        
    }
}
