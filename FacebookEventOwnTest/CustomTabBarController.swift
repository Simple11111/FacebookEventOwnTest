//
//  CustomTabBarController.swift
//  FacebookEventOwnTest
//
//  Created by Yan Paing Hein on 5/25/16.
//  Copyright © 2016 YanPaingHein. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homePageViewController = HomePageViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: homePageViewController)
        
        navigationController.title = "Events"
        navigationController.tabBarItem.image = UIImage(named: "events")
        
        let searchViewController = SearchViewController()
        let secondNavigationContoller = UINavigationController(rootViewController: searchViewController)
        
        secondNavigationContoller.title = "Search"
        secondNavigationContoller.tabBarItem.image = UIImage(named: "search")
        
        let discoverViewController = DiscoverViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let thirdNavigationController = UINavigationController(rootViewController: discoverViewController)
        
        discoverViewController.title = "Discover"
        discoverViewController.tabBarItem.image = UIImage(named: "discover")
        
        let settingViewController = UIViewController()
        let fourthNavigationController = UINavigationController(rootViewController: settingViewController)

        settingViewController.title = "Settings"
        settingViewController.tabBarItem.image = UIImage(named: "settings")
        
        viewControllers = [navigationController, secondNavigationContoller, thirdNavigationController, fourthNavigationController]
        
        tabBar.translucent = true
        
        let topBorder = CALayer()
        topBorder.frame = CGRectMake(0, 0, 1000, 0.5)
        topBorder.backgroundColor = UIColor(red: 229/255.0, green: 231/255.0, blue: 235/255.0, alpha: 1).CGColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }
}
