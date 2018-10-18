//
//  HomeViewController.swift
//  SampleHG
//
//  Created by Chandana on 10/6/18.
//  Copyright © 2018 Chandana. All rights reserved.
//
import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let homeViewModel = HomeViewModel()
    private var cells = [ExpandableSection]()
    private var textFieldtexts = [String]()
    private var tableViewRowNumbers = [[Int]]()
    private var textFieldNumbers = [[Int]]()
    var datePickerView: UIDatePicker?
    let dateFormatter = DateFormatter()
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Demo"
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: Constants.FONT, size: 19)]
        self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes as [NSAttributedString.Key: Any]
    }
    
    @objc func keyboardDidShow(with notification: Notification) {
        if let userInfo = notification.userInfo {
            let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size.height
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    @objc func keyboardWillHide(with notification: Notification) {
        UIView.animate(withDuration: 0.25) {
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        setTableViewCellTitles()
        hideKeyboardWhenTappedAround()
        tableView.backgroundColor = .white
    }
    
    private func setTableViewCellTitles() {
        cells = homeViewModel.setTableViewCellTitles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(with:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(with:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        getIndexArray()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !cells[section].isExpanded {
            return 0
        } else if section == 1 || section == 3 { //DoubleTextFieldCell sections
            return cells[section].cellTitles.count/2
        }
        return cells[section].cellTitles.count
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 128.0/255.0, green: 0, blue: 0, alpha: 0.95)
        
        let label = UILabel()
        label.textColor = .white
        label.text = homeViewModel.getHeaderTitles()[section]
        label.font = UIFont(name: Constants.FONT, size: 17)
        label.frame = CGRect(x: 16, y: 0, width: tableView.frame.width, height: 44)
        view.addSubview(label)
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: tableView.frame.width - 24, height: 44)
        button.setTitle(cells[section].isExpanded ? "^" : "v", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont(name: Constants.FONT, size: 17)
        button.tag = section
        button.addTarget(self, action: #selector(didTapSectionHeaderButton), for: .touchUpInside)
        view.addSubview(button)
        
        return view
    }
    
    @objc func didTapSectionHeaderButton(button: UIButton) {
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in cells[section].cellTitles.indices {
            if section == 1 || section == 3 { //DoubleTextFieldCell sections
                if row % 2 == 0 {
                    let indexPath = IndexPath(row: row/2, section: button.tag)
                    indexPaths.append(indexPath)
                }
            } else {
                let indexPath = IndexPath(row: row, section: button.tag)
                indexPaths.append(indexPath)
            }
            
        }
        let isExpanded = cells[section].isExpanded
        cells[section].isExpanded = !isExpanded
        button.setTitle(isExpanded ? "v" : "^", for: .normal)
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .none)
        } else {
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    private func getIndexArray() {
        let numberOfSections = tableView.numberOfSections
        var rowCount = 0
        var textFieldCount = 0
        for sectionIndex in 0..<numberOfSections {
            tableViewRowNumbers.append([Int]())
            textFieldNumbers.append([Int]())
            
            let numberOfRows = cells[sectionIndex].cellTitles.count
            for rowIndex in 0..<tableView.numberOfRows(inSection: sectionIndex) {
                tableViewRowNumbers[sectionIndex].append(rowIndex + rowCount)
            }
            
            for textFieldIndex in 0..<numberOfRows {
                textFieldNumbers[sectionIndex].append(textFieldIndex + textFieldCount)
            }
            rowCount += tableView.numberOfRows(inSection: sectionIndex)
            textFieldCount += cells[sectionIndex].cellTitles.count
        }
        print(tableViewRowNumbers)
        print(textFieldNumbers)
    }
    
    private func configureSingleTextFieldCell(indexPath: IndexPath, cellIndex: Int) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SINGLE_TEXTFIELD, for: indexPath) as? SingleTextFieldCell else {
            fatalError(Constants.FATAL_ERROR)
        }        
        cell.cellTextField.tag = cellIndex
        cell.cellTextField.placeholder = homeViewModel.getPlaceholderString(in: indexPath.section, at: indexPath.row)
        cell.cellTextField.delegate = self
        cell.configureCell(title: cells[indexPath.section].cellTitles[indexPath.row])
        if cellIndex < textFieldtexts.count {
            cell.cellTextField.text = self.textFieldtexts[cellIndex]
        } else {
            cell.cellTextField.text = Constants.EMPTY_STRING
        }
        return cell
    }
    
    private func configureDoubleTextFieldCell(indexPath: IndexPath, cellIndex: Int) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DOUBLE_TEXTFIELD, for: indexPath) as? DoubleTextFieldCell else {
            fatalError(Constants.FATAL_ERROR)
        }
        var leftIndex: Int
        if indexPath.row == 0 {
            leftIndex = cellIndex
        } else {
            leftIndex = textFieldNumbers[indexPath.section][0] + ((indexPath.row) * 2)
        }
        setDoubleTextFieldCellProperties(cell: cell, indexPath: indexPath, leftIndex: leftIndex)
        if leftIndex < textFieldtexts.count - 1 {
            cell.leftTextField.text = self.textFieldtexts[leftIndex]
            cell.rightTextField.text = self.textFieldtexts[leftIndex + 1]
        } else {
            cell.leftTextField.text = Constants.EMPTY_STRING
            cell.rightTextField.text = Constants.EMPTY_STRING
        }
        return cell
    }
    
    private func setDoubleTextFieldCellProperties(cell: DoubleTextFieldCell, indexPath: IndexPath, leftIndex: Int) {
        cell.setLabels(leftName: cells[indexPath.section].cellTitles[indexPath.row * 2], rightName: cells[indexPath.section].cellTitles[indexPath.row * 2 + 1])
        
        cell.leftTextField.placeholder = homeViewModel.getPlaceholderString(in: indexPath.section, at: indexPath.row * 2)
        cell.rightTextField.placeholder = homeViewModel.getPlaceholderString(in: indexPath.section, at: indexPath.row * 2 + 1)
        
        cell.leftTextField.tag = leftIndex
        cell.rightTextField.tag = cell.leftTextField.tag + 1
        
        cell.leftTextField.delegate = self
        cell.rightTextField.delegate = self
    }
    
    private func configureYearCell(indexPath: IndexPath, cellIndex: Int) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "YearCell", for: indexPath) as? YearCell else {
            fatalError(Constants.FATAL_ERROR)
        }
        cell.setLabel(title: cells[indexPath.section].cellTitles[indexPath.row])
        cell.yearTextField.placeholder = homeViewModel.dateTextFieldPlaceholder
        cell.yearTextField.delegate = self
        cell.yearTextField.tag = cellIndex
        if cellIndex < textFieldtexts.count {
            cell.yearTextField.text = self.textFieldtexts[cellIndex]
        } else {
            cell.yearTextField.text = Constants.EMPTY_STRING
        }
        return cell
    }
    
    private func configureDateCell(indexPath: IndexPath, cellIndex: Int) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DATE_CELL, for: indexPath) as? DatePickerCell else {
            fatalError(Constants.FATAL_ERROR)
        }
        cell.configureCell(title: cells[indexPath.section].cellTitles[indexPath.row])
        cell.dateTextField.delegate = self
        cell.dateTextField.placeholder = homeViewModel.dateTextFieldPlaceholder
        cell.dateTextField.tag = cellIndex
        if cellIndex < textFieldtexts.count {
            cell.dateTextField.text = self.textFieldtexts[cellIndex]
        } else {
            cell.dateTextField.text = Constants.EMPTY_STRING
        }
        createPickerView(sender: cell.dateTextField)
        return cell
    }
    
    private func createPickerView(sender: UITextField) {
        datePickerView = UIDatePicker()
        datePickerView?.datePickerMode = UIDatePicker.Mode.date
        sender.inputView = datePickerView
        datePickerView?.tag = sender.tag
        datePickerView?.addTarget(self, action: #selector(datePickerValueChanged(caller:)), for: UIControl.Event.valueChanged)
    }
    
    @objc func datePickerValueChanged(caller: UIDatePicker) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let indexRow = caller.tag
        let indexPath: IndexPath
        
        //Only rows with datepicker fields
        if indexRow < 13 {
            indexPath = getIndexPath(section: 2, row: indexRow)
        } else if indexRow >= 27 && indexRow <= 28 {
            indexPath = getIndexPath(section: 4, row: indexRow)
        } else {
            indexPath = getIndexPath(section: 5, row: indexRow)
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? DatePickerCell else {
            return
        }
        cell.dateTextField.text = dateFormatter.string(from: caller.date)
        cell.dateTextField.tag = indexRow
    }
    
    @objc func dismissPicker() {
        self.view.endEditing(true)
    }
    
    private func getIndexPath(section: Int, row: Int) -> IndexPath {
        var count: Int = 0
        for currentSection in 0..<section {
            count += textFieldNumbers[currentSection].count
        }
        let indexPath = IndexPath(row: row - count, section: section)
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndex = textFieldNumbers[indexPath.section][indexPath.row]
        let conditionForDateCell = cells[indexPath.section].cellTitles[indexPath.row].lowercased().range(of: "date") != nil
        let conditionForYearCell = cells[indexPath.section].cellTitles[indexPath.row].lowercased().range(of: "year") != nil
        let conditionForDoubleTextField = indexPath.section == 1 || indexPath.section == 3
        let cell: UITableViewCell
        
        if conditionForDoubleTextField {
            cell = configureDoubleTextFieldCell(indexPath: indexPath, cellIndex: cellIndex)
        } else if conditionForDateCell {
            cell = configureDateCell(indexPath: indexPath, cellIndex: cellIndex)
        } else if conditionForYearCell {
            cell = configureYearCell(indexPath: indexPath, cellIndex: cellIndex)
        } else {
            cell = configureSingleTextFieldCell(indexPath: indexPath, cellIndex: cellIndex)
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.textAlignment = .left
        let row = textField.tag
        if row >= textFieldtexts.count {
            for _ in ((textFieldtexts.count)..<row+1) {
                textFieldtexts.append(Constants.EMPTY_STRING)
                // add blank rows in case user skips rows
            }
        }
        guard let enteredText = textField.text else {
            return
        }
        textFieldtexts[row] = enteredText
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let placeholder = textField.placeholder else {
            return
        }
        if homeViewModel.getDecimalPadArray().contains(placeholder.lowercased()) {
            textField.keyboardType = .decimalPad
        } else if homeViewModel.getNumberPadArray().contains(placeholder.lowercased()) {
            textField.keyboardType = .numberPad
        } else {
            textField.keyboardType = .default
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let r = Range(range, in: text) else {
            return true
        }
        if textField.keyboardType == .decimalPad {
            let newText = text.replacingCharacters(in: r, with: string)
            let isNumeric = newText.isEmpty || (Double(newText) != nil)
            let numberOfDots = newText.components(separatedBy: ".").count - 1
            
            let numberOfDecimalDigits: Int
            if let dotIndex = newText.index(of: ".") {
                numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
            } else {
                numberOfDecimalDigits = 0
            }
            return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
        }
        return true
    }
}
