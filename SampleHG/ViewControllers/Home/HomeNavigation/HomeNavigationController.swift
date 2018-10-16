//
//  HomeNavigationController.swift
//  SampleHG
//
//  Created by Chandana on 10/6/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import UIKit

class HomeNavigationController: UINavigationController {
    private let homeViewController = UIViewController.home
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [homeViewController]
    }
}
