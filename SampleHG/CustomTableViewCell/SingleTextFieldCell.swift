//
//  customTableViewCell.swift
//  SampleHG
//
//  Created by Chandana on 10/6/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation
import UIKit

class SingleTextFieldCell: UITableViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellTextField: UITextField!
    
    func configureCell(title: String?) {
        cellLabel.text = title
    }
}
