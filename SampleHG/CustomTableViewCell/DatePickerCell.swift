//
//  DatePickerCell.swift
//  SampleHG
//
//  Created by Chandana on 10/10/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation
import UIKit

class DatePickerCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let toolBar = UIToolbar().ToolbarPiker(selector: #selector(HomeViewController.dismissPicker))
        dateTextField.inputAccessoryView = toolBar
        dateTextField.inputView = UIDatePicker()
    }
    
    func configureCell(title: String?) {
        titleLabel.text = title
    } 
}
