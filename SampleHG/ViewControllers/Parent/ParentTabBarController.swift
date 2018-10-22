//
//  ParentViewController.swift
//  SampleHG
//
//  Created by Chandana on 10/18/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation
import UIKit

class ParentTabBarController: UITabBarController {
    private let homeNavigationController = UIViewController.homeNavigationController
    private let photosNavigationController = UIViewController.photosNavigationController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        setupNavigationBar()
        setupTabBar()
    }
    
    func setupNavigationBar() {
        let navigation = UINavigationBar.appearance()
        
        let navigationFont = UIFont(name: Constants.FONT, size: 20)
        let navigationLargeFont = UIFont(name: Constants.FONT, size: 34)
        
        navigation.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.color, NSAttributedString.Key.font: navigationFont as Any]
        
        if #available(iOS 11, *) {
            navigation.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.color, NSAttributedString.Key.font: navigationLargeFont as Any]
        }
    }
    
    func setupTabBar() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: Constants.FONT, size: 10) as Any], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: Constants.FONT, size: 10) as Any], for: .selected)
        tabBar.tintColor = Constants.color
        tabBar.unselectedItemTintColor = .black
        
        homeNavigationController.tabBarItem = UITabBarItem(title: Constants.DETAILS, image: UIImage(named: Constants.DETAILS), selectedImage: nil)
        photosNavigationController.tabBarItem = UITabBarItem(title: Constants.PHOTOS, image: UIImage(named: Constants.PHOTOS), selectedImage: nil)
        self.viewControllers = [homeNavigationController, photosNavigationController]
    }
}
