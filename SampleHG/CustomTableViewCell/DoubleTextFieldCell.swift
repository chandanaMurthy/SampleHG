//
//  TwoTextFieldCell.swift
//  SampleHG
//
//  Created by Chandana on 10/8/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation
import UIKit

class DoubleTextFieldCell: UITableViewCell {
    @IBOutlet weak var rightTextField: UITextField!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var leftTextField: UITextField!
    
    func setLabels(leftName: String?, rightName: String?) {
        leftLabel.text = leftName
        rightLabel.text = rightName
        
    }
}
