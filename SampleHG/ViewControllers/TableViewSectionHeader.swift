//
//  TableViewSectionHeader.swift
//  SampleHG
//
//  Created by Chandana on 10/5/18.
//  Copyright © 2018 Chandana. All rights reserved.
//

import Foundation
import UIKit

class TableViewSectionHeader: UITableViewHeaderFooterView {
    let titleLabel = UILabel()
    let arrowLabel = UILabel()
    weak var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowLabel)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeader(gestureRecognizer:))))
    }
    
    @objc func tapHeader(gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? TableViewSectionHeader else {
            return
        }
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func rotate(view: UIView) {
        UIView.animate(withDuration: 2) {
            view.transform = CGAffineTransform(rotationAngle: .pi/2)
        }
    }
    
    func setCollapsed(collapsed: Bool) {
        if !collapsed {
            rotate(view: arrowLabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol CollapsibleTableViewHeaderDelegate: class {
    func toggleSection(header: TableViewSectionHeader, section: Int)
}
