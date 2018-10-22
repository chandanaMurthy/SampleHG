//
//  UIViewController.swift
//  SampleHG
//
//  Created by Chandana on 10/5/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    private static func instantiateFromStoryboard<T: UIViewController>(storyboard: UIStoryboard, identifier: String, to type: T.Type) -> T {
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("There is no identifier set as \(identifier)")
        }
        return viewController
    }
    
    static let HOME_VIEW_CONTROLLER = "HomeViewController"
    static var home: HomeViewController {
        return UIViewController.instantiateFromStoryboard(storyboard: UIStoryboard.home, identifier: HOME_VIEW_CONTROLLER, to: HomeViewController.self)
    }
    
    static let HOME_NAVIGATION_CONTROLLER = "HomeNavigationController"
    static var homeNavigationController: HomeNavigationController {
        return UIViewController.instantiateFromStoryboard(storyboard: UIStoryboard.homeNavigationController, identifier: HOME_NAVIGATION_CONTROLLER, to: HomeNavigationController.self)
    }
    
    static let PHOTOS_VIEW_CONTROLLER = "PhotosViewController"
    static var photos: PhotosViewController {
        return UIViewController.instantiateFromStoryboard(storyboard: UIStoryboard.photos, identifier: PHOTOS_VIEW_CONTROLLER, to: PhotosViewController.self)
    }
    
    static let PHOTOS_NAVIGATION_CONTROLLER = "PhotosNavigationController"
    static var photosNavigationController: PhotosNavigationController {
        return UIViewController.instantiateFromStoryboard(storyboard: UIStoryboard.photosNavigationController, identifier: PHOTOS_NAVIGATION_CONTROLLER, to: PhotosNavigationController.self)
    }
}
