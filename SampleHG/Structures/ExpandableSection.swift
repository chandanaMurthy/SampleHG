//
//  Section.swift
//  SampleHG
//
//  Created by Chandana on 10/5/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation

struct ExpandableSection {
    var cellTitles: [String]
    var isExpanded: Bool
    
    init(cellTitles: [String], isExpanded: Bool) {
        self.cellTitles = cellTitles
        self.isExpanded = isExpanded
    }
}
