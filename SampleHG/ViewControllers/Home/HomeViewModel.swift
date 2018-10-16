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
    private let propAddress = ["Address", "Apt/Unit", "City",
                               "State/Prov", "ZipCode", "Country",
                               "MLS Number", "Parcel/Tax ID"]
    private let listingInfo = ["Expiration Date", "Listing Date", "Original Price",
                               "Current Price", "1st Mortgage Balance", "2nd Mortgage Balance",
                               "Other Liens", "Description of Other Liens",
                               "HomeOwner's Association", "Total Encumbrances"]
    private let geoDesc = ["MLS Area", "Legal Description", "Map Grid",
                           "Subdivision", "Lot", "Block"]
    private let contractDates = ["Contract Agreement Date", "Closing Date"]
    private let offerDates = ["Inspection Date", "Offer Date", "Offer Expiration Date"]
    private let property = ["Year Built", "Bedrooms", "Square Footage"]
    
    private let headerTitles = ["Participants", "Property Address",
                                "Listing Information", "Geographic Description",
                                "Contract Dates", "Offer Dates", "Property"]
    private var placeholderStrings = [[String]]()
    let dateTextFieldPlaceholder = "Click to Select"
    
    func getHeaderTitles() -> [String] {
        return headerTitles
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
        let titles = [participants, propAddress, listingInfo, geoDesc, contractDates, offerDates, property]
        return titles
    }
}
