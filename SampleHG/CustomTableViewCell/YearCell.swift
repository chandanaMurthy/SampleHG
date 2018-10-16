//
//  YearCell.swift
//  SampleHG
//
//  Created by Chandana on 10/16/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation
import UIKit

class YearCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var yearTextField: UITextField!
    var yearPicker: UIPickerView!
    var yearsTillNow: [String] {
        var years = [String]()
        for year in (1100..<2019).reversed() {
            years.append("\(year)")
        }
        return years
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        yearPicker = UIPickerView()
        yearPicker.dataSource = self
        yearPicker.delegate = self
        yearTextField.inputView = yearPicker
        yearTextField.text = yearsTillNow[0]
        let toolBar = UIToolbar().ToolbarPiker(selector: #selector(HomeViewController.dismissPicker))
        yearTextField.inputAccessoryView = toolBar
    }
    
    func setLabel(title: String) {
        label.text = title
    }
}

extension YearCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearsTillNow.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yearsTillNow[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yearTextField.text = yearsTillNow[row]
    }
}
