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
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Stats", bundle: nil)
        let viewController:UIViewController = storyBoard.instantiateViewController(withIdentifier: "StatsNavigationController") as UIViewController
        viewController.tabBarItem.title = "Statistics"
        viewController.tabBarItem.image = UIImage(named: "statistics_tab")
        
        var controllers = self.viewControllers
        controllers?.insert(viewController, at: 0)
        self.viewControllers = controllers
    }
}
