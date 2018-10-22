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
    private var yearPicker: UIPickerView!
    private let yearViewModel = YearCellViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        yearPicker = UIPickerView()
        yearPicker.dataSource = self
        yearPicker.delegate = self
        yearTextField.inputView = yearPicker
        yearTextField.text = yearViewModel.getYear(at: 0)
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
        return yearViewModel.getYearCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yearViewModel.getYear(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yearTextField.text = yearViewModel.getYear(at: row)
    }
}
