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
}
