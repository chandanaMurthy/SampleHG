//
//  PhotosNavigationController.swift
//  SampleHG
//
//  Created by Chandana on 10/18/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation
import UIKit

class PhotosNavigationController: UINavigationController {
    private let photosViewController = UIViewController.photos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [photosViewController]
    }
}
