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
        //let viewController:UIViewController = storyBoard.instantiateViewController(withIdentifier: "StatsViewController") as UIViewController
        let viewController:UIViewController = storyBoard.instantiateViewController(withIdentifier: "StatsNavigationController") as UIViewController
        //let icon1 = UITabBarItem(title: "Title", image: UIImage(named: "someImage.png"), selectedImage: UIImage(named: "otherImage.png"))
        viewController.tabBarItem.title = "Statistics"
        
        var controllers = self.viewControllers
        controllers?.insert(viewController, at: 0)
        self.viewControllers = controllers
    }
}
