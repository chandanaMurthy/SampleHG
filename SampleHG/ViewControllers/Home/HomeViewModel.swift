//
//  HomeViewModel.swift
//  SampleHG
//
//  Created by Chandana on 10/5/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation

class HomeViewModel {
    private let participants = ["Name", "Role", "Email"]
    private let propAddress = ["Address", "Apt/Unit", "City", "State/Prov",
                               "ZipCode", "Country", "MLS Number", "Parcel/Tax ID"]
    private let listingInfo = ["Expiration Date", "Listing Date", "Original Price",
                               "Current Price", "1st Mortgage Balance", "2nd Mortgage Balance",
                               "Other Liens", "Description of Other Liens",
                               "HomeOwner's Association", "Total Encumbrances"]
    private let geoDesc = ["MLS Area", "Legal Description", "Map Grid",
                           "Subdivision", "Lot Name", "Block"]
    private let contractDates = ["Contract Agreement Date", "Closing Date"]
    private let offerDates = ["Inspection Date", "Offer Date", "Offer Expiration Date"]
    private let property = ["Year Built", "Bedrooms", "Square Footage"]
    private let headerTitles = ["Participants", "Property Address", "Listing Information",
                                "Geographic Description", "Contract Dates", "Offer Dates", "Property"]
    
    private let decimalPadArray = ["original price", "current price", "1st mortgage balance", "2nd mortgage balance", "square footage", "mls area", "total encumbrances"]
    private let numberPadArray = ["zipcode", "block", "mls number", "bedrooms", "apt/unit", "parcel/tax id"]
    
    private var placeholderStrings = [[String]]()
    private var titles = [ExpandableSection]()
    let PICKERFIELD_PLACEHOLDER = "Click to Select"
    let OPEN = "v"
    let CLOSE = "^"
    let DATE = "date"
    let YEAR = "year"
    
    func decimalPadArrayContains(element: String) -> Bool {
        return decimalPadArray.contains(element)
    }
    
    func numberPadArrayContains(element: String) -> Bool {
        return numberPadArray.contains(element)
    }
    
    func getHeaderTitle(at index: Int) -> String {
        return headerTitles[index]
    }
    
    func getPlaceholderString(in section: Int, at row: Int) -> String {
        placeholderStrings = [participants, propAddress, listingInfo, geoDesc, contractDates, offerDates, property]
        return placeholderStrings[section][row]
    }
    
    private func getSectionDetails(titles: [String]) -> ExpandableSection {
        let expandableSection = ExpandableSection(cellTitles: titles, isExpanded: true)
        return expandableSection
    }
    
    func setTableViewCellTitles() -> [ExpandableSection] {
        let participants = getSectionDetails(titles: self.participants)
        let propAddress = getSectionDetails(titles: self.propAddress)
        let listingInfo = getSectionDetails(titles: self.listingInfo)
        let geoDesc = getSectionDetails(titles: self.geoDesc)
        let contractDates = getSectionDetails(titles: self.contractDates)
        let offerDates =  getSectionDetails(titles: self.offerDates)
        let property = getSectionDetails(titles: self.property)
        titles = [participants, propAddress, listingInfo, geoDesc, contractDates, offerDates, property]
        return titles
    }
    
    func totalCellCount() -> Int {
        return titles.count
    }
    
    func cellTitleCount(in section: Int) -> Int {
        return titles[section].cellTitles.count
    }
    
    func getCellName(section: Int, row: Int) -> String {
        return titles[section].cellTitles[row]
    }
    
    func section(at index: Int) -> ExpandableSection {
        return titles[index]
    }
}
