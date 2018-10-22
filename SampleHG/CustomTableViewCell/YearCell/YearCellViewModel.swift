//
//  YearCellViewModel.swift
//  SampleHG
//
//  Created by Chandana on 10/22/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation

class YearCellViewModel {
    private var yearsTillNow: [String] {
        var years = [String]()
        for year in (1100..<2019).reversed() {
            years.append("\(year)")
        }
        return years
    }
    
    func getYear(at index: Int) -> String {
        return yearsTillNow[index]
    }
    
    func getYearCount() -> Int {
        return yearsTillNow.count
    }
}
