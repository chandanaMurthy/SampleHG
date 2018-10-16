//
//  UITextField.swift
//  SampleHG
//
//  Created by Chandana on 10/12/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    //open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    //    return false
    //}
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.select(_:)) || action == #selector(UIResponderStandardEditActions.selectAll(_:))
    }
}
