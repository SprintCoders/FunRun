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
        
        let statsStoryBoard: UIStoryboard = UIStoryboard(name: "Stats", bundle: nil)
        let statsViewController:UIViewController = statsStoryBoard.instantiateViewController(withIdentifier: "StatsViewController") as UIViewController
        //let icon1 = UITabBarItem(title: "Title", image: UIImage(named: "someImage.png"), selectedImage: UIImage(named: "otherImage.png"))
        statsViewController.tabBarItem.title = "Statistics"
        
        var controllers = self.viewControllers
        controllers?.insert(statsViewController, at: 0)
        self.viewControllers = controllers
    }
}
