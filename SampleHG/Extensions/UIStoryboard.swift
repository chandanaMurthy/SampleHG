//
//  UIStoryboard.swift
//  SampleHG
//
//  Created by Chandana on 10/5/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    private static let HOME_VIEW_CONTROLLER = "HomeViewController"
    static var home: UIStoryboard {
        return UIStoryboard(name: HOME_VIEW_CONTROLLER, bundle: nil)
    }
    
    private static let HOME_NAVIGATION_CONTROLLER = "HomeNavigationController"
    static var homeNavigationController: UIStoryboard {
        return UIStoryboard(name: HOME_NAVIGATION_CONTROLLER, bundle: nil)
    }
    
    private static let PHOTOS_VIEW_CONTROLLER = "PhotosViewController"
    static var photos: UIStoryboard {
        return UIStoryboard(name: PHOTOS_VIEW_CONTROLLER, bundle: nil)
    }
    
    private static let PHOTOS_NAVIGATION_CONTROLLER = "PhotosNavigationController"
    static var photosNavigationController: UIStoryboard {
        return UIStoryboard(name: PHOTOS_NAVIGATION_CONTROLLER, bundle: nil)
    }
    
}
